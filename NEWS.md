# dbhydroR 0.2-9

## Minor changes

* Maintenance release to fix testing on CRAN

# dbhydroR 0.2-8 

## Minor changes

* Switched all URLs from http to https
* Now caching test web requests

# dbhydroR 0.2-7 (2019-02-15)

## Bug fixes

* Fixed critical bug in `get_hydro` causing data parsing failure in all cases (#16)

# dbhydroR 0.2-6 (2018-07-19)

## Bug fixes

* Fixed critical bug in `get_hydro` causing data parsing failure in all cases

# dbhydroR 0.2-5 (2018-05-21)

## Bug fixes

* `get_dbkey` was incorrectly processing data headers

## Minor changes

* Rebranded from ropenscilabs to ropensci
* Converted vignette to rmarkdown

# dbhydroR 0.2-4 (2017-10-30)

## Bug fixes

* The ArcGIS online station map no longer resolves. Links have been updated.
* Sweave sty files are excluded in CRAN build.

# dbhydroR 0.2-3 (2017-08-02)

## Bug fixes

* `get_hydro()` now resolves multiple matching of on-the-fly dbkeys to the one with the longest period of record.

## Minor changes

* Fixed broken links
* Add rOpenSci badge

# dbhydroR 0.2-2 (2017-02-03)

## Bug fixes

`get_hydro()` now works if a `dbkey` contains leading zeros

# dbhydroR 0.2-1 (2016-11-23)

## Minor changes

* Improved installation instructions in vignette.
* Added package level documentation.
* Added rOpenSci branding.
* Use https. #6

# dbhydroR 0.2

## Major changes

* The package API has been changed to underscored function names. `getwq()`, `gethydro()`, and `getdbkey()` are now deprecated in favor of `get_wq()`, `get_hydro()`, `get_dbkey()`.

## Bug fixes

* `getdbkey()` is no longer limited to < 100 results
* MDL (Minumum Detection Limit) handling now occurs in `getwq()` regardless of how the `raw` parameter is set
* `getwq()` returns a no data warning even if the `raw` parameter is set to `TRUE`
* `gethydro()` and `getwq()` date/time stamps are now forced to the `EST` timezone independently of the user environment
* The character encoding of function results is forced to `UTF-8` regardless of the user environment

## Minor changes

* Documentation formatting is now consistent with CRAN policies
* Added links to the ArcGIS Online Station Map in the README and vignette
* `getdbkey()` coordinates are now in decimal degree format

# dbhydroR 0.1-6

## Minor changes

* Added argument to handle MDLs (Minimum Detection Limits) in `getwq()`


# dbhydroR 0.1-5

## Major changes

* Added ability to pass a vector of values to `getdbkey()` arguments
* Added ability to fully define a unique dbkey in `getdbkey()`

## Minor changes

* Document MDL handling in `cleanwq()`
* Added unit tests
* Remove standalone plotting functions
* Cleanup source code formatting

# dbhydroR 0.1-4

## Bug fixes

* Improvements to `gethydro()` to guess missing column names of instantaneous data
