### R code from vignette source 'dbhydroR.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: dbhydroR.Rnw:49-50
###################################################
options(continue = "+", width = 50, useFancyQuotes = FALSE)


###################################################
### code chunk number 2: dbhydroR.Rnw:53-56 (eval = FALSE)
###################################################
## install.packages("B:\\restoration_sciences\\projects\\joe_stachelek
##                  \\R\\dbhydro_0.1-1.zip",type="win.binary",
##                  repos=NULL,dependencies=TRUE)


###################################################
### code chunk number 3: dbhydroR.Rnw:63-64
###################################################
library(dbhydroR)


###################################################
### code chunk number 4: dbhydroR.Rnw:73-74 (eval = FALSE)
###################################################
## example(dbhydro_get)


###################################################
### code chunk number 5: dbhydroR.Rnw:80-82 (eval = FALSE)
###################################################
## dbhydro_get(station_id="FLAB08", date_min="2011-03-01",
##             date_max="2012-05-01",test_name="CHLOROPHYLLA-SALINE")


###################################################
### code chunk number 6: dbhydroR.Rnw:87-89 (eval = FALSE)
###################################################
## dbhydro_get(station_id=c("FLAB08","FLAB09"), date_min="2011-03-01",
##             date_max="2012-05-01",test_name="CHLOROPHYLLA-SALINE")


###################################################
### code chunk number 7: dbhydroR.Rnw:94-96 (eval = FALSE)
###################################################
## dbhydro_get(station_id=c("FLAB0%"), date_min="2011-03-01",
##             date_max="2012-05-01",test_name="CHLOROPHYLLA-SALINE")


###################################################
### code chunk number 8: dbhydroR.Rnw:101-104 (eval = FALSE)
###################################################
## dbhydro_get(station_id=c("FLAB08","FLAB09"), date_min="2011-03-01",
##             date_max="2012-05-01",test_name=c("CHLOROPHYLLA-SALINE",
##                                               "SALINITY"))


###################################################
### code chunk number 9: dbhydroR.Rnw:111-114 (eval = FALSE)
###################################################
## dbhydro_get(station_id="FLAB08", date_min="2011-03-01",
##             date_max="2011-05-01",test_name="CHLOROPHYLLA-SALINE",
##             raw=TRUE)


###################################################
### code chunk number 10: dbhydroR.Rnw:121-122 (eval = FALSE)
###################################################
## example(dbhydro_plot)


###################################################
### code chunk number 11: dbhydroR.Rnw:127-132 (eval = FALSE)
###################################################
## dt<-dbhydro_get(station_id=c("FLAB08","FLAB09"),
##                 date_min="2011-03-01",date_max="2014-05-01",
##                 test_name=c("CHLOROPHYLLA-SALINE","SALINITY"))
##   
## dbhydro_plot(dt,label="bottomleft",abb=3)


