dbhydroR 0.2-3 (2017-08-02)
===================

### BUG FIXES

* `get_hydro()` now resolves multiple matching of on-the-fly dbkeys to the one with the longest period of record.

### MINOR IMPROVEMENTS

* Fixed broken links
* Add rOpenSci badge

dbhydroR 0.2-2 (2017-02-03)
===================

### BUG FIXES
`get_hydro()` now works if a `dbkey` contains leading zeros

dbhydroR 0.2-1 (2016-11-23)
===================

### MINOR IMPROVEMENTS

* Improved installation instructions in vignette.
* Added package level documentation.
* Added rOpenSci branding.
* Use https. #6

dbhydroR 0.2
===================

### DEPRECATED

* The package API has been changed to underscored function names. `getwq()`, `gethydro()`, and `getdbkey()` are now deprecated in favor of `get_wq()`, `get_hydro()`, `get_dbkey()`.

### BUG FIXES

* `getdbkey()` is no longer limited to < 100 results
* MDL (Minumum Detection Limit) handling now occurs in `getwq()` regardless of how the `raw` parameter is set
* `getwq()` returns a no data warning even if the `raw` parameter is set to `TRUE`
* `gethydro()` and `getwq()` date/time stamps are now forced to the `EST` timezone independently of the user environment
* The character encoding of function results is forced to `UTF-8` regardless of the user environment

### MINOR IMPROVEMENTS

* Documentation formatting is now consistent with CRAN policies
* Added links to the ArcGIS Online Station Map in the README and vignette
* `getdbkey()` coordinates are now in decimal degree format

dbhydroR 0.1-6
===================

### NEW FEATURES

* Added argument to handle MDLs (Minimum Detection Limits) in `getwq()`


dbhydroR 0.1-5
===================

### NEW FEATURES

* Added ability to pass a vector of values to `getdbkey()` arguments
* Added ability to fully define a unique dbkey in `getdbkey()`

### MINOR IMPROVEMENTS

* Document MDL handling in `cleanwq()`
* Added unit tests
* Remove standalone plotting functions
* Cleanup source code formatting

dbhydroR 0.1-4
===================

### BUG FIXES

* Improvements to `gethydro()` to guess missing column names of instantaneous data
