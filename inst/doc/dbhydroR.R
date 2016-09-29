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
### code chunk number 3: dbhydroR.Rnw:63-64 (eval = FALSE)
###################################################
## devtools::install_github("ropenscilabs/dbhydroR")


###################################################
### code chunk number 4: dbhydroR.Rnw:71-72
###################################################
library(dbhydroR)


###################################################
### code chunk number 5: dbhydroR.Rnw:81-82 (eval = FALSE)
###################################################
## example(get_wq)


###################################################
### code chunk number 6: dbhydroR.Rnw:88-90 (eval = FALSE)
###################################################
## get_wq(station_id = "FLAB08", date_min = "2011-03-01", 
##       date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")


###################################################
### code chunk number 7: dbhydroR.Rnw:95-97 (eval = FALSE)
###################################################
## get_wq(station_id = c("FLAB08","FLAB09"), date_min = "2011-03-01",
##       date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")


###################################################
### code chunk number 8: dbhydroR.Rnw:102-104 (eval = FALSE)
###################################################
## get_wq(station_id = c("FLAB0%"), date_min = "2011-03-01", 
##       date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")


###################################################
### code chunk number 9: dbhydroR.Rnw:109-112 (eval = FALSE)
###################################################
## get_wq(station_id = c("FLAB08","FLAB09"), date_min = "2011-03-01",
##       date_max = "2012-05-01", test_name = c("CHLOROPHYLLA-SALINE",
##       "SALINITY"))


###################################################
### code chunk number 10: dbhydroR.Rnw:119-122 (eval = FALSE)
###################################################
## raw_wq <- get_wq(station_id = "FLAB08", date_min = "2011-03-01", 
##       date_max = "2011-05-01", test_name = "CHLOROPHYLLA-SALINE",
##       raw = TRUE)


###################################################
### code chunk number 11: dbhydroR.Rnw:127-128 (eval = FALSE)
###################################################
## clean_wq(raw_wq)


###################################################
### code chunk number 12: dbhydroR.Rnw:135-137 (eval = FALSE)
###################################################
## get_dbkey(stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          detail.level = "summary")


###################################################
### code chunk number 13: dbhydroR.Rnw:142-144 (eval = FALSE)
###################################################
## get_dbkey(stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          freq = "DA", detail.level = "full")


###################################################
### code chunk number 14: dbhydroR.Rnw:149-152 (eval = FALSE)
###################################################
## get_dbkey(stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          freq = "DA", stat = "MEAN", recorder = "CR10", agency = "WMD",
##          detail.level = "dbkey")


###################################################
### code chunk number 15: dbhydroR.Rnw:157-159 (eval = FALSE)
###################################################
## get_hydro(dbkey = "15081",
##          date_min = "2013-01-01", date_max = "2013-02-02")


###################################################
### code chunk number 16: dbhydroR.Rnw:164-167 (eval = FALSE)
###################################################
## get_hydro(date_min = "2013-01-01", date_max = "2013-02-02",
##          stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          freq = "DA", stat = "MEAN", recorder = "CR10", agency = "WMD")


###################################################
### code chunk number 17: dbhydroR.Rnw:172-174 (eval = FALSE)
###################################################
## get_hydro(dbkey = c("15081", "15069"), date_min = "2013-01-01",
##          date_max = "2013-02-02")


###################################################
### code chunk number 18: dbhydroR.Rnw:177-180 (eval = FALSE)
###################################################
## get_hydro(date_min = "2013-01-01", date_max = "2013-02-02",
##          category = "WEATHER", stationid = c("JBTS", "MBTS"),
##          param = "WNDS", freq = "DA", stat = "MEAN")


###################################################
### code chunk number 19: dbhydroR.Rnw:185-187 (eval = FALSE)
###################################################
## example(get_dbkey)
## example(get_hydro)


###################################################
### code chunk number 20: dbhydroR.Rnw:192-197 (eval = FALSE)
###################################################
## raw_data <- get_hydro(date_min = "2013-01-01", date_max = "2013-02-02",
##          stationid = "JBTS", category = "WEATHER", param = "WNDS",
##          freq = "DA", stat = "MEAN", recorder = "CR10", agency = "WMD", raw = TRUE)
##          
## clean_hydro(raw_data)


