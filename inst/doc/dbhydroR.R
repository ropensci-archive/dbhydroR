### R code from vignette source 'dbhydroR.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: dbhydroR.Rnw:50-51
###################################################
options(width = 50, useFancyQuotes = FALSE, prompt = " ", continue = " ")


###################################################
### code chunk number 2: dbhydroR.Rnw:56-57 (eval = FALSE)
###################################################
## install.packages("dbhydroR")


###################################################
### code chunk number 3: dbhydroR.Rnw:61-62 (eval = FALSE)
###################################################
## devtools::install_github("SFWMD/dbhydro")


###################################################
### code chunk number 4: dbhydroR.Rnw:69-70
###################################################
library(dbhydroR)


###################################################
### code chunk number 5: dbhydroR.Rnw:79-80 (eval = FALSE)
###################################################
## example(getwq)


###################################################
### code chunk number 6: dbhydroR.Rnw:86-88 (eval = FALSE)
###################################################
## getwq(station_id = "FLAB08", date_min = "2011-03-01", 
##       date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")


###################################################
### code chunk number 7: dbhydroR.Rnw:93-95 (eval = FALSE)
###################################################
## getwq(station_id = c("FLAB08","FLAB09"), date_min = "2011-03-01",
##       date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")


###################################################
### code chunk number 8: dbhydroR.Rnw:100-102 (eval = FALSE)
###################################################
## getwq(station_id = c("FLAB0%"), date_min = "2011-03-01", 
##       date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")


###################################################
### code chunk number 9: dbhydroR.Rnw:107-110 (eval = FALSE)
###################################################
## getwq(station_id = c("FLAB08","FLAB09"), date_min = "2011-03-01",
##       date_max = "2012-05-01", test_name = c("CHLOROPHYLLA-SALINE",
##       "SALINITY"))


###################################################
### code chunk number 10: dbhydroR.Rnw:117-120 (eval = FALSE)
###################################################
## raw_wq <- getwq(station_id = "FLAB08", date_min = "2011-03-01", 
##       date_max = "2011-05-01", test_name = "CHLOROPHYLLA-SALINE",
##       raw = TRUE)


###################################################
### code chunk number 11: dbhydroR.Rnw:125-126 (eval = FALSE)
###################################################
## cleanwq(raw_wq)


###################################################
### code chunk number 12: dbhydroR.Rnw:133-135 (eval = FALSE)
###################################################
## getdbkey(stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          detail.level = "summary")


###################################################
### code chunk number 13: dbhydroR.Rnw:140-142 (eval = FALSE)
###################################################
## getdbkey(stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          freq = "DA", detail.level = "full")


###################################################
### code chunk number 14: dbhydroR.Rnw:147-150 (eval = FALSE)
###################################################
## getdbkey(stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          freq = "DA", stat = "MEAN", recorder = "CR10", agency = "WMD",
##          detail.level = "dbkey")


###################################################
### code chunk number 15: dbhydroR.Rnw:155-157 (eval = FALSE)
###################################################
## gethydro(dbkey = "15081",
##          date_min = "2013-01-01", date_max = "2013-02-02")


###################################################
### code chunk number 16: dbhydroR.Rnw:162-165 (eval = FALSE)
###################################################
## gethydro(date_min = "2013-01-01", date_max = "2013-02-02",
##          stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          freq = "DA", stat = "MEAN", recorder = "CR10", agency = "WMD")


###################################################
### code chunk number 17: dbhydroR.Rnw:170-172 (eval = FALSE)
###################################################
## gethydro(dbkey = c("15081", "15069"), date_min = "2013-01-01",
##          date_max = "2013-02-02")


###################################################
### code chunk number 18: dbhydroR.Rnw:175-178 (eval = FALSE)
###################################################
## gethydro(date_min = "2013-01-01", date_max = "2013-02-02",
##          category = "WEATHER", stationid = c("JBTS", "MBTS"),
##          param = "WNDS", freq = "DA", stat = "MEAN")


###################################################
### code chunk number 19: dbhydroR.Rnw:183-185 (eval = FALSE)
###################################################
## example(getdbkey)
## example(gethydro)


###################################################
### code chunk number 20: dbhydroR.Rnw:190-195 (eval = FALSE)
###################################################
## raw_data <- gethydro(date_min = "2013-01-01", date_max = "2013-02-02",
##          stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          freq = "DA", stat = "MEAN", recorder = "CR10", agency = "WMD", raw = TRUE)
##          
## cleanhydro(raw_data)


