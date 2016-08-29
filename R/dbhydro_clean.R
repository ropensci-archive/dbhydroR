#'@name cleanwq
#'@title Clean raw water quality DBHYDRO data retrievals
#'@description Removes extra columns associated with QA flags and QA blanks which are used to check on potential sources of contamination. If raw is set to TRUE, \code{\link{getwq}} results are converted from long (each piece of data on its own row) to \code{wide} format (each site x variable combination in its own column).
#'@export
#'@importFrom reshape2 dcast
#'@param dt data.frame output of \code{\link{getwq}}
#'@param raw logical default is FALSE, set to TRUE to return data in "long" format with all comments, qa information, and database codes included
#'@param mdl_handling character string specifying the handling of measurement values below the minimum detection limit (MDL). Example choices for this argument include:
#'\itemize{
#'\item \code{raw}: Returns values exactly as they are stored in the database. Current practice is to return values below the MDL as 0 minus the uncertainty estimate.
#'\item \code{half}: Returns values below the MDL as half the MDL
#'\item \code{full}: Returns values below the MDL as the MDL
#'}
#'
#'@examples \dontrun{
#'#check handling of values below MDL
#' dt <- getwq("FLAB01", "2014-09-14", "2014-09-18", "NITRATE+NITRITE-N", raw = TRUE)
#' cleanwq(dt, mdl_handling = "raw")
#' cleanwq(dt, mdl_handling = "half")
#'}
#'
#'dt <- read.csv(system.file("extdata", "testwq.csv", package = "dbhydroR"))
#'cleanwq(dt)

cleanwq <- function(dt, raw = FALSE, mdl_handling = "raw"){
  if(!(mdl_handling %in% c("raw", "half", "full"))){
    stop("mdl_handling must be one of 'raw', 'half', or 'full'")
  }
  
  dt <- dt[dt$Matrix != "DI",]
  
  dt$date <- as.POSIXct(strptime(dt$Collection_Date, format = "%d-%b-%Y"),
              tz = "America/New_York") 
  
  correct_mdl <- function(dt, mdl_handling){
    if(any(dt$Value < 0 & !is.na(dt$Value)) & mdl_handling != "raw"){
      if(mdl_handling == "half"){
        dt[dt$Value < 0 & !is.na(dt$Value), "Value"] <- 
          dt[dt$Value < 0 & !is.na(dt$Value), "MDL"] / 2
      }else{
        dt[dt$Value < 0 & !is.na(dt$Value), "Value"] <- 
          dt[dt$Value < 0 & !is.na(dt$Value), "MDL"]
      }
    }
    dt
  }
  
  dt <- correct_mdl(dt, mdl_handling)
  
  if(raw  == TRUE){
    dt
  }else{
    dt <- dt[,c(1:23, which(names(dt) == "date"))]  
    dwide <- reshape2::dcast(dt, date ~ Station.ID + Test.Name + Units,
           value.var = "Value", add.missing = TRUE, fun.aggregate = mean)
    #if(any(names(dwide)=="_")){dwide<-dwide[,-which(names(dwide)=="_")]}
    # if(ncol(dwide) > 2){
    #   dwide <- dwide[,-2]
    # }
    if(nrow(dwide[is.na(dwide[,1]),]) > 0){
      dwide <- dwide[-which(is.na(dwide[,1])),]
    }
  
    dwide
  }
}

#'@name cleanhydro
#'@title Clean raw hydrologic DBHYDRO data retrievals
#'@description Converts output of \code{\link{gethydro}} from long (each piece of data on its own row) to wide format (each site x variable combination in its own column). Metadata (station-name, variable, measurement units) is parsed so that it is wholly contained in column names. 
#'@export
#'@importFrom reshape2 dcast
#'@param dt data.frame output of \code{\link[dbhydroR]{gethydro}}
#'@examples
#'\dontrun{
#'cleanhydro(gethydro(dbkey = "15081", date_min = "2013-01-01", date_max = "2013-02-02", raw = TRUE))
#'}

cleanhydro <- function(dt){
    reshape2::dcast(dt, date ~ station + type + units, value.var = "data.value",
      add.missing = TRUE, fun.aggregate = mean)
}
