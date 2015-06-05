#'@name dbydro_plot
#'@title Plot DBHYDRO data retrievals
#'@param dt output of dbhydro_get
#'@param type string plot type
#'@param label string placement of site label choice of "topleft", "topright", "bottomleft", or "bottomright"
#'@param abb integer number of characters to abbreviate y-axis label
#'@export
#'@examples
#'dt<-dbhydro_get(station_id=c("FLAB08","FLAB09"),date_min="2011-03-01",date_max="2014-05-01",test_name=c("CHLOROPHYLLA-SALINE","SALINITY"))
#'dbhydro_plot(dt,label="bottomleft",abb=3)

dbhydro_plot<-function(dt,label="topleft",type="b",abb = Inf){

  sites<-unlist(lapply(strsplit(names(dt)[2:ncol(dt)],"_"),function(x) x[1]))
  vars<-unlist(lapply(strsplit(names(dt)[2:ncol(dt)],"_"),function(x) x[2]))
  units<-unlist(lapply(strsplit(names(dt)[2:ncol(dt)],"_"),function(x) x[3]))
  
  for(i in 1:length(unique(vars))){
    #i<-1
    ind<-which(vars==unique(vars)[i])
    rng<-c(min(dt[ind+1]),max(dt[ind+1]))
    
    par(mfrow=c(length(ind),1))
    par(mar=c(3,5,1,1))
    
    if(length(ind)==1){
      suppressWarnings(plot(dt$date,dt[,ind[1]+1],xlab="",ylab=paste(abbreviate(vars[ind[1]],minlength=abb,strict=TRUE)," (",units[ind[1]],")",sep=""),type=type,ylim=rng)) 
      legend(label,legend=sites[ind[1]],box.col="black")  
    }else{
      for(j in 1:(length(ind)-1)){
        suppressWarnings(plot(dt$date,dt[,ind[j]+1],xaxt="n",ylab=paste(abbreviate(vars[ind[j]],minlength = abb,strict = TRUE)," (",units[ind[1]],")",sep=""),type=type,ylim=rng)) 
        legend(label,legend=sites[ind[j]],box.col="black")
      }
      suppressWarnings(plot(dt$date,dt[,ind[length(ind)]+1],xlab="",ylab=paste(abbreviate(vars[ind[length(ind)]],minlength = abb,strict = TRUE)," (",units[ind[length(ind)]],")",sep=""),type=type,ylim=rng)) 
      legend(label,legend=sites[ind[length(ind)]],box.col="black")
      
      
    }
  }
}
    
    

    
  


