
![](inst/images/profile.png)

# Programmatic access to the South Florida Water Management District's [DBHYDRO database](http://my.sfwmd.gov/dbhydroplsql/show_dbkey_info.main_menu)

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Travis-CI Build Status](https://travis-ci.org/SFWMD/dbhydro.svg?branch=master)](https://travis-ci.org/SFWMD/dbhydro)

## Installation

`install.packages("devtools") #Requires RTools if using Windows`

`devtools::install_github("SFWMD/dbhydro")`

### Load dbhydroR

`library("dbhydroR")`

## Usage

### One variable at one station
```
getwq(station_id = "FLAB08", date_min = "2011-03-01", 
      date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")
```

### One variable at multiple stations 
```
getwq(station_id = c("FLAB08","FLAB09"), date_min = "2011-03-01",
      date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")
```

### One variable at a wildcard station
```
getwq(station_id = c("FLAB0%"), date_min = "2011-03-01", 
      date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE")
```

### Multiple variables at multiple stations
```
getwq(station_id = c("FLAB08","FLAB09"), date_min = "2011-03-01",
      date_max = "2012-05-01", test_name = c("CHLOROPHYLLA-SALINE",
      "SALINITY"))
```

### Hydrologic data
```
gethydro(date_min = "2013-01-01", date_max = "2013-02-02",
         stationid = "JBTS", category = "WEATHER", param = "WNDS",
         freq = "DA", stat = "MEAN", recorder = "CR10", agency = "WMD")
```

## References

`vignette("dbhydroR", package = "dbhydroR")`

[DBHYDRO User's Guide](http://www.sfwmd.gov/portal/page/portal/xrepository/sfwmd_repository_pdf/dbhydrobrowseruserdocumentation.pdf)

