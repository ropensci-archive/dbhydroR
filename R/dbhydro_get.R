#'@name getwq
#'@title Retrieve water quality data from the DBHYDRO Environmental Database
#'@description South Florida Water Management District
#'@param station_id character string of station id(s)
#'@param date_min character must be in POSIXct YYYY-MM-DD format
#'@param date_max character must be in POSIXct YYYY-MM-DD format
#'@param test_name character string of test name(s)
#'@param raw logical default is FALSE, set to TRUE to return data in "long" format with all comments, qa information, and database codes included. 
#'@param qc_strip logical set TRUE to avoid returning QAQC flagged data entries
#'@param qc_field logical set TRUE to avoid returning field QC results
#'@param test_number numeric test name alternative (not implemented)
#'@param v_target_code string print to file? (not implemented)
#'@param sample_id numeric (not implemented)
#'@param project_code numeric (not implemented)
#'@details TODO: return warning when no data rather than error
#'@export
#'@import httr
#'@import RCurl
#'@examples
#'
#'#one variable and one station
#'getwq(station_id="FLAB08",
#'date_min="2011-03-01",date_max="2012-05-01",
#'test_name="CHLOROPHYLLA-SALINE")
#'\dontrun{
#'#one variable at multiple stations
#'getwq(station_id=c("FLAB08","FLAB09"),
#'date_min="2011-03-01",date_max="2012-05-01",
#'test_name="CHLOROPHYLLA-SALINE")
#'
#'#One variable at a wildcard station
#'getwq(station_id=c("FLAB0%"),
#'date_min="2011-03-01",
#'date_max="2012-05-01",
#'test_name="CHLOROPHYLLA-SALINE")
#'
#'#multiple variables at multiple stations
#'getwq(station_id=c("FLAB08","FLAB09"),
#'date_min="2011-03-01",date_max="2012-05-01",
#'test_name=c("CHLOROPHYLLA-SALINE","SALINITY"))
#'}


getwq<-function(station_id=NA,date_min=NA,date_max=NA,test_name=NA,raw=FALSE,qc_strip="N",qc_field="N",test_number=NA,v_target_code="file_csv",sample_id=NA,project_code=NA){
  
  servfull <- "http://my.sfwmd.gov/dbhydroplsql/water_quality_data.report_full"
  
  #try(ping<-RCurl::getURL("http://www.sfwmd.gov/portal/page/portal/sfwmdmain/home%20page"),silent=TRUE)
  #if(!exists("ping")){stop("no internet connection")}
  
  station_like<-station_id[grepl("%",station_id)]
  if(length(station_like)>0){
    station_id<-station_id[!grepl("%",station_id)]
    station_like<-paste("(",paste("'",station_like,"'",sep="",collapse=","),")",sep="")
  }else{
    station_like<-NA
  }
  
  station_list<-paste("(",paste("'",station_id,"'",sep="",collapse=","),")",sep="")
  
  if(!is.na(date_min)){
  date_min<-strftime(date_min,format="%d-%b-%Y")
  date_min<-paste("> ","'",date_min,"'",sep="")
  }
  if(!is.na(date_max)){
  date_max<-strftime(date_max,format="%d-%b-%Y")
  date_max<-paste("< ","'",date_max,"'",sep="")
  }
  
  test_list<-paste("(",paste("'",test_name,"'",sep="",collapse=","),")",sep="")
  
  if(qc_strip==TRUE){
    qc_strip<-"Y"
  }
  if(qc_field==TRUE){
    qc_field<-"Y"
  }
  
  if(length(station_like)>0&any(!is.na(station_like))){
    qy<-list(v_where_clause=paste("where","date_collected",date_min,"and","date_collected",date_max,"and","station_id","like",station_like,"and","test_name","in",test_list,sep=" "),v_target_code=v_target_code,v_exc_flagged=qc_strip,v_exc_qc=qc_field)
  }else{
  qy<-list(v_where_clause=paste("where","date_collected",date_min,"and","date_collected",date_max,"and","station_id","in",station_list,"and","test_name","in",test_list,sep=" "),v_target_code=v_target_code,v_exc_flagged=qc_strip,v_exc_qc=qc_field)
  }
  
  res<-httr::GET(servfull,query=qy)
  
  if(raw==TRUE){
    read.csv(text=httr::content(res,"text"))
  }else{
    if(!any(!is.na(read.csv(text=httr::content(res,"text"))))){
      message("No data found")
    }else{
    cleanwq(read.csv(text=httr::content(res,"text")))
    }
  }
}


#'@name gethydro
#'@title Retrieve hydrologic data from the DBHYDRO Environmental Database
#'@description South Florida Water Management District
#'@param dbkey character string of time series identifiers (e.g. Joe Bay mean daily wind speed is "15081"). These are listed alongside each time series in DBHYDRO.
#'@param stationid character string Station ID
#'@param category character string, choice of "WEATHER","SW","GW", or "WQ"
#'@param param character string parameter query
#'@param date_min character must be in POSIXct YYYY-MM-DD format
#'@param date_max character must be in POSIXct YYYY-MM-DD format
#'@param period string optional return data from the last X days (not implemented)
#'@param v_target_code string print to file? (not implemented)
#'@export
#'@import httr
#'@import RCurl
#'@examples
#'\dontrun{
#'#One variable/station time series
#'gethydro(dbkey="15081",date_min="2013-01-01",date_max="2013-02-02")
#'
#'#Multiple variable/station time series
#'gethydro(dbkey=c("15081","15069"),
#'date_min="2013-01-01",date_max="2013-02-02")
#'
#'#Instantaneous hydro retrieval
#'gethydro(dbkey="IY639", date_min="2009-01-30", date_max="2015-11-04")
#'
#'#Looking up unknown dbkeys
#'gethydro(stationid="JBTS",category="WEATHER",
#'param="WNDS",date_min="2013-01-01",
#'date_max="2013-02-02")
#'}

gethydro<-function(dbkey=NA,stationid=NA,category=NA,param=NA,date_min=NA,date_max=NA,period="uspec",v_target_code="file_csv"){

  if((is.na(stationid)|is.na(category))& all(is.na(dbkey))){
    stop("Must specify either a dbkey or stationid/category/param.")
  }
  
  if(!is.na(stationid)){
    dbkey<-getdbkey(stationid = stationid,category = category,param = param,blind = TRUE)
  }
  
  if(length(dbkey)>1){
    dbkey<-paste(dbkey,"/",collapse="",sep="")
    dbkey<-substring(dbkey,1,(nchar(dbkey)-1))
  }
  
  servfull <- "http://my.sfwmd.gov/dbhydroplsql/web_io.report_process"
  
  if(!is.na(date_min)){
    date_min<-strftime(date_min,format="%Y%m%d")
    }
  if(!is.na(date_max)){
    date_max<-strftime(date_max,format="%Y%m%d")
    }
  
  qy<-list(v_period=period,v_start_date=date_min,v_end_date=date_max,v_report_type="format6",v_target_code=v_target_code,v_run_mode="onLine",v_js_flag="Y",v_dbkey=dbkey)
  
  res<-httr::GET(servfull,query=qy)
  cleanhydro(res)
}

#'@name getdbkey
#'@title Retrieve a list of dbkeys from a DBHYDRO station ID
#'@export
#'@param stationid character string
#'@param category character string, choice of "WEATHER","SW","GW", or "WQ"
#'@param param string optional desired parameter name
#'@param blind logical output dbkey results as object (TRUE) or simply print query results (FALSE)?
#'@param freq character string frequency choice of daily ("DA")
#'@details A value in the "Recorder" field on "PREF" should be used whenever possible. This indicates that the dataset has been checked by the SFWMD modeling group.
#'@import XML
#'@examples
#'getdbkey(stationid="JBTS",category="WEATHER",param="WNDS")
#'getdbkey(stationid="C111%",category="SW")
#'getdbkey(stationid="C111%",category="GW")
#'getdbkey(stationid="C111%",category="WQ")
#'getdbkey(stationid="JBTS",category="WEATHER",param="WNDS")

getdbkey<-function(stationid,category,param=NA,freq="DA",blind=FALSE){

  servfull <- "http://my.sfwmd.gov/dbhydroplsql/show_dbkey_info.show_dbkeys_matched"
  
  qy<-list(v_js_flag="Y",v_category=category,v_station=stationid,v_dbkey_list_flag="Y",v_order_by="STATION")
  res<-httr::GET(servfull,query=qy)
  res <- sub('.*(<table class="grid".*?>.*</table>).*', '\\1', httr::content(res,"text"))
  
  res<-XML::readHTMLTable(res)[[3]][,c("Dbkey", "Group", "Data Type", "Freq", "Recorder", "Start Date", "End Date")]
  
  if(!is.na(param)){
    res<-res[as.character(res[,"Data Type"])==param,]
  }
  if(!is.na(freq)){
    res<-res[as.character(res[,"Freq"])==freq,]
  }
  res[,1]<-as.character(res[,1])
  
  if(blind==FALSE){
    message(paste("Search results for"," '",stationid," ",category,"'",sep=""))
  print(res)
  }else{
   res[,1] 
  }
}