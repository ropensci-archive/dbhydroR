#'@name dbhydro_clean
#'@title Clean raw DBHYDRO data retrievals
#'@description remove extra qa/db columns, remove qa "blanks", and convert results from long to wide format.
#'@export
#'@import reshape2
#'@param dt data.frame output of dbhydro_get
#'@examples
#'dt<-read.csv(system.file("extdata","test.csv",package="dbhydroR"))
#'dbhydro_clean(dt)

dbhydro_clean<-function(dt){
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