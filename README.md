
![](inst/images/profile.png)

# Programmatic access to the South Florida Water Management District's [DBHYDRO database](http://sfwmd.gov/dbhydro)

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Travis-CI Build Status](https://travis-ci.org/SFWMD/dbhydroR.svg?branch=master)](https://travis-ci.org/SFWMD/dbhydroR)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/dbhydroR)](https://cran.r-project.org/package=dbhydroR) 
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/dbhydroR)](https://cran.r-project.org/package=dbhydroR)

`dbhydroR` provides scripted access to the South Florida Water Management District's DBHYDRO database which holds over 35 million hydrolgic and water quality records from the Florida Everglades and surrounding areas. 

## Installation

### Stable version from CRAN

`install.packages("dbhydroR")`

### or development version from Github

`install.packages("devtools") # Requires RTools if using Windows`

`devtools::install_github("SFWMD/dbhydro")`

## Usage

### Load dbhydroR

`library("dbhydroR")`

### Water Quality Data

Station IDs and date ranges can be viewed in the [ArcGIS Online Station Map](http://my.sfwmd.gov/WAB/EnvironmentalMonitoring/index.html). Test names can be viewed in the [Data Types Metadata Table](http://my.sfwmd.gov/dbhydroplsql/show_dbkey_info.show_data_type_info).

#### One variable at one station
```
getwq(station_id = "FLAB08", date_min = "2011-03-01", 
      date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")
```

#### One variable at multiple stations 
```
getwq(station_id = c("FLAB08","FLAB09"), date_min = "2011-03-01",
      date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")
```

#### One variable at a wildcard station
```
getwq(station_id = c("FLAB0%"), date_min = "2011-03-01", 
      date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")
```

#### Multiple variables at multiple stations
```
getwq(station_id = c("FLAB08","FLAB09"), date_min = "2011-03-01",
      date_max = "2012-05-01", test_name = c("CHLOROPHYLLA-SALINE",
      "SALINITY"))
```

#### Operate on raw data
```
raw_data <- getwq(station_id = "FLAB08", date_min = "2011-03-01", 
      date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE", raw = TRUE)

cleanwq(raw_data)
```

### Hydrologic data
Station IDs and date ranges can be viewed in the [ArcGIS Online Station Map](http://my.sfwmd.gov/WAB/EnvironmentalMonitoring/index.html). 

#### Identify unique time series (dbkeys) before-hand
```
getdbkey(stationid = "C111%", stat = 'MEAN', category = "WQ", detail.level = "full")
gethydro(dbkey = 38104, date_min = "2009-01-01", date_max = "2009-01-12")
```

#### Pass station info on-the-fly
```
gethydro(date_min = "2013-01-01", date_max = "2013-02-02",
         stationid = "JBTS", category = "WEATHER", param = "WNDS",
         freq = "DA", stat = "MEAN", recorder = "CR10", agency = "WMD")
```

#### Operate on raw data
```
raw_data <- gethydro(date_min = "2013-01-01", date_max = "2013-02-02",
         stationid = "JBTS", category = "WEATHER", param = "WNDS",
         freq = "DA", stat = "MEAN", recorder = "CR10", agency = "WMD", raw = TRUE)
         
cleanhydro(raw_data)
```

## References

`vignette("dbhydroR", package = "dbhydroR")`

[DBHYDRO User's Guide](http://www.sfwmd.gov/portal/page/portal/xrepository/sfwmd_repository_pdf/dbhydrobrowseruserdocumentation.pdf)

## Meta

* Please [report any issues or bugs](https://github.com/SFWMD/dbhydroR/issues).

* Get citation information for `dbhydroR` in R by running `citation(package = 'dbhydroR')`

* Please note that this project is released with a [Contributor Code of Conduct](https://github.com/SFWMD/dbhydroR/blob/master/CONDUCT.md). By participating in this project you agree to abide by its terms