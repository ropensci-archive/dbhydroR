#'@name dbydro_plot
#'
#'

station_id<-c("FLAB08")
date_min<-"2011-03-20"
date_max<-"2014-05-20"
test_name=c("CHLOROPHYLLA-SALINE")
dt<-dbhydro_get(station_id,date_min,date_max,test_name,qc_field=TRUE)


dbhydro_plot<-function(dt,type="l"){
names(dt)<-tolower(names(dt))
dt$collection_date<-as.POSIXct(strptime(dt$collection_date,format="%d-%b-%Y"))

plot(dt$collection_date,dt$value,xlab="",ylab=paste(dt$test.name[1]," (",dt$units[1],")",sep=""),type=type)

}


