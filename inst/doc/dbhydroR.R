### R code from vignette source 'dbhydroR.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: dbhydroR.Rnw:50-51
###################################################
options(width = 50, useFancyQuotes = FALSE)


###################################################
### code chunk number 2: dbhydroR.Rnw:64-65
###################################################
library(dbhydroR)


###################################################
### code chunk number 3: dbhydroR.Rnw:74-75 (eval = FALSE)
###################################################
## example(getwq)


###################################################
### code chunk number 4: dbhydroR.Rnw:81-83 (eval = FALSE)
###################################################
## getwq(station_id = "FLAB08", date_min = "2011-03-01", 
##       date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")


###################################################
### code chunk number 5: dbhydroR.Rnw:88-90 (eval = FALSE)
###################################################
## getwq(station_id = c("FLAB08","FLAB09"), date_min = "2011-03-01",
##       date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")


###################################################
### code chunk number 6: dbhydroR.Rnw:95-97 (eval = FALSE)
###################################################
## getwq(station_id = c("FLAB0%"), date_min = "2011-03-01", 
##       date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")


###################################################
### code chunk number 7: dbhydroR.Rnw:102-105 (eval = FALSE)
###################################################
## getwq(station_id = c("FLAB08","FLAB09"), date_min = "2011-03-01",
##       date_max = "2012-05-01", test_name = c("CHLOROPHYLLA-SALINE",
##       "SALINITY"))


###################################################
### code chunk number 8: dbhydroR.Rnw:112-115 (eval = FALSE)
###################################################
## getwq(station_id = "FLAB08", date_min = "2011-03-01", 
##       date_max = "2011-05-01", test_name = "CHLOROPHYLLA-SALINE",
##       raw = TRUE)


###################################################
### code chunk number 9: dbhydroR.Rnw:122-124 (eval = FALSE)
###################################################
## getdbkey(stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          detail.level = "summary")


###################################################
### code chunk number 10: dbhydroR.Rnw:129-131 (eval = FALSE)
###################################################
## getdbkey(stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          freq = "DA", detail.level = "full")


###################################################
### code chunk number 11: dbhydroR.Rnw:136-139 (eval = FALSE)
###################################################
## getdbkey(stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          freq = "DA", stat = "MEAN", recorder = "CR10", agency = "WMD",
##          detail.level = "dbkey")


###################################################
### code chunk number 12: dbhydroR.Rnw:144-146 (eval = FALSE)
###################################################
## gethydro(dbkey = "15081",
##          date_min = "2013-01-01", date_max = "2013-02-02")


###################################################
### code chunk number 13: dbhydroR.Rnw:151-154 (eval = FALSE)
###################################################
## gethydro(date_min = "2013-01-01", date_max = "2013-02-02",
##          stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          freq = "DA", stat = "MEAN", recorder = "CR10", agency = "WMD")


###################################################
### code chunk number 14: dbhydroR.Rnw:159-161 (eval = FALSE)
###################################################
## gethydro(dbkey = c("15081", "15069"), date_min = "2013-01-01",
##          date_max = "2013-02-02")


###################################################
### code chunk number 15: dbhydroR.Rnw:164-167 (eval = FALSE)
###################################################
## gethydro(date_min = "2013-01-01", date_max = "2013-02-02",
##          category = "WEATHER", stationid = c("JBTS", "MBTS"),
##          param = "WNDS", freq = "DA", stat = "MEAN")


###################################################
### code chunk number 16: dbhydroR.Rnw:172-174 (eval = FALSE)
###################################################
## example(getdbkey)
## example(gethydro)


