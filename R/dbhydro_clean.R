#'@name cleanwq
#'@title Clean raw water quality DBHYDRO data retrievals
#'@description remove extra qa/db columns, remove qa "blanks", and convert results from long to wide format.
#'@export
#'@import reshape2
#'@param dt data.frame output of getwq
#'@examples
#'dt<-read.csv(system.file("extdata","testwq.csv",package="dbhydroR"))
#'cleanwq(dt)

cleanwq<-function(dt){
  dt<-dt[,1:23]
  dt<-dt[dt$Matrix!="DI",]
  
  dt$date<-as.POSIXct(strptime(dt$Collection_Date,format="%d-%b-%Y")) 
  dwide<-reshape2::dcast(dt,date ~ Station.ID + Test.Name + Units, value.var="Value",add.missing=T,fun.aggregate=mean)
  
  #if(any(names(dwide)=="_")){dwide<-dwide[,-which(names(dwide)=="_")]}
  dwide<-dwide[,-2]
  
  if(nrow(dwide[is.na(dwide[,1]),])>0){
  dwide<-dwide[-which(is.na(dwide[,1])),]
  }
  
  dwide
}

#'@name cleanhydro
#'@title Clean raw hydrologic DBHYDRO data retrievals
#'@description Cleans to by consistent with water quality formatting. Connects metadata header to actual measurements.
#'@export
#'@import reshape2
#'@param res output of gethydro of class "response"
#'@examples
#'\dontrun{
#'cleanhydro(gethydro(dbkey="15081",date_min="2013-01-01",date_max="2013-02-02"))
#'}

cleanhydro<-function(res){
  
  i<-1
  while(any(!is.na(read.csv(text=httr::content(res,"text"),skip=i,stringsAsFactors = FALSE,header=FALSE)[i,10:16]))){
    i<-i+1
  }
  
  metadata<-read.csv(text=httr::content(res,"text"),skip=1,stringsAsFactors = FALSE)[1:(i-1),]
  dt<-read.csv(text=httr::content(res,"text"),skip=i+1,stringsAsFactors = FALSE)
  dt<-merge(metadata,dt)
  dt$date<-as.POSIXct(strptime(dt$Daily.Date,format="%d-%b-%Y"))
  
  reshape2::dcast(dt,date ~ Station + TYPE + UNITS,value.var="Data.Value",add.missing=T,fun.aggregate=mean)
  
}