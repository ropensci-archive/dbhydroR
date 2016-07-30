#'@name getwq
#'@title Retrieve water quality data from the DBHYDRO Environmental Database
#'@description Retrieve water quality data from the DBHYDRO Environmental Database
#'@param station_id character string of station id(s)
#'@param date_min character date must be in POSIXct YYYY-MM-DD format
#'@param date_max character date must be in POSIXct YYYY-MM-DD format
#'@param test_name character string of test name(s). See vignette for specific options
#'@param raw logical default is FALSE, set to TRUE to return data in "long" format with all comments, qa information, and database codes included. 
#'@param qc_strip logical set TRUE to avoid returning QAQC flagged data entries
#'@param qc_field logical set TRUE to avoid returning field QC results
#'@param test_number numeric test name alternative (not implemented)
#'@param v_target_code string print to file? (not implemented)
#'@param sample_id numeric (not implemented)
#'@param project_code numeric (not implemented)
#'@param mdl_handling character specify values to return for measurements below the minimum detection limit choice of "raw", "half", or "full".
#'@export
#'@import httr
#'@import RCurl
#'@importFrom utils read.csv
#'@examples
#'
#'#one variable and one station
#'getwq(station_id = "FLAB08",
#'date_min = "2011-03-01", date_max = "2012-05-01", 
#'test_name = "CHLOROPHYLLA-SALINE")
#'
#'\dontrun{
#'#one variable at multiple stations
#'getwq(station_id = c("FLAB08", "FLAB09"),
#'date_min = "2011-03-01", date_max = "2012-05-01",
#'test_name = "CHLOROPHYLLA-SALINE")
#'
#'#One variable at a wildcard station
#'getwq(station_id = c("FLAB0%"),
#'date_min = "2011-03-01",
#'date_max = "2012-05-01",
#'test_name = "CHLOROPHYLLA-SALINE")
#'
#'#multiple variables at multiple stations
#'getwq(station_id = c("FLAB08", "FLAB09"),
#'date_min = "2011-03-01", date_max = "2012-05-01",
#'test_name = c("CHLOROPHYLLA-SALINE", "SALINITY"))
#'}


getwq <- function(station_id = NA, date_min = NA, date_max = NA,
         test_name = NA, mdl_handling = "raw", raw = FALSE, qc_strip = "N",
         qc_field = "N", test_number = NA, v_target_code = "file_csv",
         sample_id = NA, project_code = NA){
  
  if(!(nchar(date_min) == 10 & nchar(date_max) == 10)){
    stop("Enter dates as quote-wrapped character strings in YYYY-MM-DD format")
  }
  
  servfull <- "http://my.sfwmd.gov/dbhydroplsql/water_quality_data.report_full"
  
  #try(ping<-RCurl::getURL(
  # "http://www.sfwmd.gov/portal/page/portal/sfwmdmain/home%20page"),
  # silent=TRUE)
  #if(!exists("ping")){stop("no internet connection")}
  
  station_like <- station_id[grepl("%", station_id)]
  if(length(station_like) > 0){
    station_id <- station_id[!grepl("%", station_id)]
    station_like <- paste("(", paste("'", station_like, "'", sep = "",
                    collapse = ","), ")", sep = "")
  }else{
    station_like <- NA
  }
  
  station_list <- paste("(",paste("'", station_id, "'", sep = "",
                  collapse = ","), ")", sep = "")
  
  if(!is.na(date_min)){
    date_min <- strftime(date_min, format = "%d-%b-%Y")
    date_min <- paste("> ", "'", date_min, "'", sep = "")
  }
  if(!is.na(date_max)){
    date_max <- strftime(date_max, format = "%d-%b-%Y")
    date_max <- paste("< ", "'", date_max, "'", sep = "")
  }
  
  test_list <- paste("(", paste("'", test_name, "'", sep = "",
               collapse = ","), ")", sep = "")
  
  if(qc_strip == TRUE){
    qc_strip <- "Y"
  }
  
  if(qc_field == TRUE){
    qc_field <- "Y"
  }
  
  if(length(station_like) > 0 & any(!is.na(station_like))){
    qy <- list(v_where_clause = paste("where", "date_collected", date_min,
          "and", "date_collected", date_max, "and", "station_id", "like",
          station_like, "and", "test_name", "in", test_list, sep = " "),
          v_target_code = v_target_code, v_exc_flagged = qc_strip,
          v_exc_qc = qc_field)
  }else{
    qy <- list(v_where_clause = paste("where", "date_collected", date_min,
          "and", "date_collected", date_max, "and", "station_id", "in",
          station_list, "and", "test_name", "in", test_list, sep = " "),
          v_target_code = v_target_code, v_exc_flagged = qc_strip,
          v_exc_qc = qc_field)
  }
  
  res <- httr::GET(servfull, query = qy)
  res <- suppressMessages(read.csv(text = httr::content(res, "text"),
         stringsAsFactors = FALSE, na.strings = c(" ", "")))
  res <- res[rowSums(is.na(res)) != ncol(res),]
  
  if(raw == TRUE){
    res
  }else{
    if(!any(!is.na(res)) | !any(res$Matrix != "DI")){
      message("No data found")
    }else{
      cleanwq(res, mdl_handling = mdl_handling)
    }
  }
}


#'@name gethydro
#'@title Retrieve DBHYDO hydrologic data
#'@description Retrieve hydrologic data from the DBHYDRO Environmental Database
#'@param dbkey character string dataset identifier. See \code{\link[dbhydroR]{getdbkey}}
#'@param date_min character date must be in YYYY-MM-DD format
#'@param date_max character date must be in YYYY-MM-DD format
#'@param ... Options passed on to \code{\link[dbhydroR]{getdbkey}}
#'@export
#'@import httr
#'@import RCurl
#'@examples
#'\dontrun{
#'#One variable/station time series
#'gethydro(dbkey = "15081", date_min = "2013-01-01", date_max = "2013-02-02")
#'
#'#Multiple variable/station time series
#'gethydro(dbkey = c("15081", "15069"),
#'date_min = "2013-01-01", date_max = "2013-02-02")
#'
#'#Instantaneous hydro retrieval
#'gethydro(dbkey = "IY639", date_min = "2009-01-30", date_max = "2015-11-04")
#'
#'#Looking up unknown dbkeys on the fly
#'gethydro(stationid = "JBTS", category = "WEATHER", 
#'param = "WNDS", date_min = "2013-01-01", 
#'date_max = "2013-02-02")
#'}

gethydro <- function(dbkey = NA, date_min = NA, date_max = NA, ...){
  
  period <- "uspec"
  v_target_code <- "file_csv"
  
  if(!(nchar(date_min) == 10 & nchar(date_max) == 10)){
    stop("Enter dates as quote-wrapped character strings in YYYY-MM-DD format")
  }

  # if((is.na(stationid) | is.na(category)) & all(is.na(dbkey))){
  #   stop("Must specify either a dbkey or stationid/category/param.")
  # }
  
  if(all(is.na(dbkey))){
    dbkey <- getdbkey(detail.level = "dbkey", ...)
  }
  
  if(length(dbkey) > 1){
    dbkey <- paste(dbkey, "/", collapse = "", sep = "")
    dbkey <- substring(dbkey, 1, (nchar(dbkey) - 1))
  }
  
  servfull <- "http://my.sfwmd.gov/dbhydroplsql/web_io.report_process"
  
  if(!is.na(date_min)){
    date_min <- strftime(date_min, format = "%Y%m%d")
  }
  if(!is.na(date_max)){
    date_max <- strftime(date_max, format = "%Y%m%d")
  }
  
  qy <- list(v_period = period, v_start_date = date_min, v_end_date = date_max,
        v_report_type = "format6", v_target_code = v_target_code,
        v_run_mode = "onLine", v_js_flag = "Y", v_dbkey = dbkey)
  
  res <- httr::GET(servfull, query = qy)
  
  try({res <- cleanhydro(res)}, silent = TRUE)
  if(class(res) == "response"){
    stop("No data found")
  }
  
  res
}

#'@name getdbkey
#'@title Query dbkey information
#'@description Retrieve a data.frame summary including dbkeys or a vector of dbkeys corresponding to specified parameters
#'@export
#'@param category character string, choice of "WEATHER", "SW", "GW", or "WQ"
#'@param stationid character string specifying station name
#'@param param character string specifying desired parameter name
#'@param freq character string specifying collection frequency (daily = "DA")
#'@param stat character string specifying statistic type
#'@param recorder character string specifying recorder information
#'@param agency character string specifying collector agency
#'@param strata numeric vector of length 2 specifying a range of z-coordinates relative to local ground elevation. Only applicable for queries in the "WEATHER" and "GW" categories.
#'@param detail.level character string specifying the level of detail to return. Choices are "full", "summary", and "dbkey".
#'@param ... Options passed as named parameters
#'@details A value in the "Recorder" field of "PREF" should be used whenever possible. This indicates that the dataset has been checked by the SFWMD modelling group.
#'@import XML
#'@importFrom stats setNames
#'@references \url{http://my.sfwmd.gov/dbhydroplsql/show_dbkey_info.main_menu}
#'@references \url{http://my.sfwmd.gov/dbhydroplsql/show_dbkey_info.show_meta_data}
#'@examples \dontrun{
#'# Weather
#'getdbkey(stationid = "JBTS", category = "WEATHER", param = "WNDS", detail.level = "summary")
#'getdbkey(stationid = "JBTS", category = "WEATHER", param = "WNDS", detail.level = "dbkey")
#'
#'# query on multiple values
#'getdbkey(stationid = c("MBTS", "JBTS"), category = "WEATHER",
#' param = "WNDS", freq = "DA", detail.level = "dbkey")
#'
#'
#'# Surfacewater
#'getdbkey(stationid = "C111%", category = "SW")
#'
#'# Groundwater
#'getdbkey(stationid = "C111%", category = "GW")
#'getdbkey(stationid = "C111AE", category = "GW", param = "WELL",
#' freq = "DA", stat = "MEAN", strata = c(9, 22), recorder = "TROL",
#'  agency = "WMD", detail.level = "full")
#'
#'# Water Quality
#'getdbkey(stationid = "C111%", category = "WQ")
#'}

getdbkey <- function(category, stationid = NA, param = NA, freq = NA,
            stat = NA, recorder = NA, agency = NA, strata = NA,
            detail.level = "summary", ...){

  if(!(detail.level %in% c("full", "summary", "dbkey"))){
    stop("Must specify either 'full', 'summary',
      or 'dbkey' for the detail.level argument ")
  }

  if(any(!is.na(strata))){
    strata_from <- strata[1]
    strata_to <- strata[2]
  }else{
    strata_from <- NA
    strata_to <- NA
  }
  
  # expand parameters with length > 1 to be seperated by "/" 
  # with no trailing "/" ####
  user_args <- list(v_category = category, v_station = stationid,
               v_data_type = param, v_frequency = freq, v_statistic_type = stat,
               v_recorder = recorder, v_agency = agency,
               v_strata_from = strata_from, v_strata_to = strata_to)
  greater_length_args <- lapply(user_args, function(x) length(x))
  if(length(which(greater_length_args > 1)) >  0){
    collapse_args <- user_args[which(greater_length_args > 1)]
    collapse_args <- paste0(do.call("c", collapse_args), "/", collapse = "")
    collapse_args <- substring(collapse_args, 1, (nchar(collapse_args) - 1))
    user_args[which(greater_length_args > 1)] <- collapse_args
  }
  
  dbhydro_args <- setNames(as.list(c("Y", "STATION", "Y")), c("v_js_flag",
                  "v_order_by", "v_dbkey_list_flag"))
  qy <- c(user_args, dbhydro_args)

  if(any(is.na(qy))){
    qy <- qy[-which(is.na(qy))]
  }
  
  servfull <- "http://my.sfwmd.gov/dbhydroplsql/show_dbkey_info.show_dbkeys_matched"
  res <- httr::GET(servfull, query = qy)
  res <- sub('.*(<table class="grid".*?>.*</table>).*', '\\1',
         suppressMessages(httr::content(res, "text")))
  
  if(length(XML::readHTMLTable(res)) < 3){
    stop("No dbkeys found")  
  }
  
  if(detail.level == "full"){
    res <- XML::readHTMLTable(res)[[3]]
  }else{
    res <- XML::readHTMLTable(res)[[3]][,c("Dbkey", "Group", "Data Type",
           "Freq", "Recorder", "Start Date", "End Date")]
  }
  
  if(nrow(res) > 1){
    not_na_col <- !(apply(res, 2, function(x) all(is.na(x))))
    if(any(not_na_col == FALSE)){
      res <- res[,not_na_col]  
    }
  }else{
    not_na_element <- which(is.na(res))
    if(length(not_na_element) > 0){
      res <- res[-not_na_element]  
    }
  }
  res[,1] <- as.character(res[,1])
  
  if(detail.level %in% c("full", "summary")){
    message(paste("Search results for", " '", stationid, " ", category, "'",
      sep = ""))
    res
  }else{
    res[,1] 
  }
  
}
