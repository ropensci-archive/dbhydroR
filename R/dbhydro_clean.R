#'@name cleanwq
#'@title Clean raw water quality DBHYDRO data retrievals
#'@description Remove extra columns associated with QA flags, LIMS, and District recieving. Remove QA "blanks". Convert results from long to wide format.
#'@details Current DBHYDRO practice is to return values below the MDL as 0 minus the uncertainty estimate.
#'@export
#'@import reshape2
#'@param dt data.frame output of \code{\link[dbhydroR]{}getwq}
#'@examples \dontrun{
#'#check handling of values below MDL
#'dt <- getwq(station_id = "FLAB08", date_min = "2009-01-01",
#' date_max = "2016-02-29", test_name = "PHOSPHATE, TOTAL AS P", raw = TRUE)
#'dt <- getwq(station_id = "FLAB08", date_min = "2009-01-01",
#' date_max = "2016-02-29", test_name = "AMMONIA-N", raw = TRUE)
#'}
#'dt <- read.csv(system.file("extdata", "testwq.csv", package = "dbhydroR"))
#'cleanwq(dt)

cleanwq <- function(dt){
  dt <- dt[,1:23]
  dt <- dt[dt$Matrix != "DI",]
  
  dt$date <- as.POSIXct(strptime(dt$Collection_Date, format = "%d-%b-%Y")) 
  dwide <- reshape2::dcast(dt, date ~ Station.ID + Test.Name + Units, value.var = "Value", add.missing = T, fun.aggregate = mean)
  
  #if(any(names(dwide)=="_")){dwide<-dwide[,-which(names(dwide)=="_")]}
  dwide <- dwide[,-2]
  
  if(nrow(dwide[is.na(dwide[,1]),]) > 0){
    dwide <- dwide[-which(is.na(dwide[,1])),]
  }
  
  dwide
}

#'@name cleanhydro
#'@title Clean raw hydrologic DBHYDRO data retrievals
#'@description Cleans to be consistent with water quality formatting. Connects metadata header to actual measurements.
#'@export
#'@import reshape2
#'@param res output of \code{\link[dbhydroR]{gethydro}}
#'@examples
#'\dontrun{
#'cleanhydro(gethydro(dbkey = "15081", date_min = "2013-01-01", date_max = "2013-02-02"))
#'}

cleanhydro <- function(res){
  
  i <- 1
  while(any(!is.na(read.csv(text = httr::content(res, "text"), skip = i, stringsAsFactors = FALSE, header = FALSE)[i, 10:16]))){
    i <- i + 1
  }
  
  metadata <- read.csv(text = httr::content(res, "text"), skip = 1, stringsAsFactors = FALSE)[1:(i - 1),]
  
  try({dt <- read.csv(text = httr::content(res, "text"), skip = i + 1, stringsAsFactors = FALSE)}, silent = T)
  if(class(dt) != "data.frame"){
    stop("No data found")
  }
  
   if(!any(names(dt) == "DBKEY")){
     warning("Column headings missing. Guessing...")
    
     names(dt) <- c("Station", "DBKEY", "Daily.Date", "Data.Value", "Qualifer", "Revision.Date")
     
     if(all(is.na(as.POSIXct(strptime(dt$Daily.Date, format = "%d-%b-%Y"))))){
       warning("Instantaneous data detected")
       
       names(dt) <- c("Inst.Date", "DCVP", "DBKEY", "Data.Value", "Code", "Quality.Flag")
       dt <- merge(metadata, dt)
       dt$date <- as.POSIXct(strptime(dt$Inst.Date, format = "%d-%b-%Y %H:%M"))
      }
  }else{
    dt <- merge(metadata, dt)
    dt$date <- as.POSIXct(strptime(dt$Daily.Date, format = "%d-%b-%Y"))
  }
  
  names(dt) <- tolower(names(dt))
  reshape2::dcast(dt, date ~ station + type + units, value.var = "data.value", add.missing = T, fun.aggregate = mean)
  
}
