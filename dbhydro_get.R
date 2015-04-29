#'@name dbhydro_get
#'@title Retrieve data from the DBHydro Database
#'@description South Florida Water Management District
#'@param station_id character string of station id(s)
#'@param date_collected character must be in POSIXct YYYY-MM-DD format
#'@param test_name character string of test name(s)
#'@param qc_strip logical set TRUE to avoid returning QAQC flagged data entries
#'@param qc_field logical set TRUE to avoid returning field QC results
#'@export
#'@example
#'station_id<-c("FLAB08")
#'date_min<-"2011-03-20"
#'date_max<-"2011-05-20"
#'test_name=c("CHLOROPHYLLA-SALINE")
#'dbhydro_get(station_id,date_min,date_max,test_name,qc_field=TRUE)
#'
#'#below is verified to work
#'library(RCurl)
#getURL("http://my.sfwmd.gov/dbhydroplsql/water_quality_data.report_full?v_where_clause=where+date_collected+>+'20-MAR-2011'+and+date_collected+<+'20-MAR-2014'+and+station_id+in+('FLAB08')+and+test_name+=+'CHLOROPHYLLA-SALINE'&v_target_code=screen")
#
#TODO: Querying with wildcards

dbhydro_get<-function(station_id=NA,date_min=NA,date_max=NA,test_name=NA,qc_strip="N",qc_field="N",test_number=NA,v_target_code="file_csv",sample_id=NA,project_code=NA){
  
  library(httr)
  servfull <- "http://my.sfwmd.gov/dbhydroplsql/water_quality_data.report_full"  
  
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
  
  qy<-list(v_where_clause=paste("where","date_collected",date_min,"and","date_collected",date_max,"and","station_id","in",station_list,"and","test_name","in",test_list,sep=" "),v_target_code=v_target_code,v_exc_flagged=qc_strip,v_exc_qc=qc_field)
  
  res<-GET(servfull,query=qy)
  read.csv(text=content(res,"text"))
}

