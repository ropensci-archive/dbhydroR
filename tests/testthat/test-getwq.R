context("getwq")

test_that("getwq works", {
  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()
  
  expect_is(getwq(station_id = c("FLAB08", "FLAB09"), date_min = "2011-03-01", date_max = "2012-05-01", test_name = "CHLOROPHYLLA-SALINE"), "data.frame")
  
})

test_that("getwq fails well", {
  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()
  
  expect_message(getwq(station_id = c("FLAB08", "FLAB09"), date_min = "1990-03-01", date_max = "1992-05-01", test_name = "CHLOROPHYLLA-SALINE"), "No data found")
  
})

test_that("non-character dates are handled", {
  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()
  
  expect_error(getwq(station_id = c("FLAB08", "FLAB09"), date_min = 1990-03-01, date_max = 1992-05-01, test_name = "CHLOROPHYLLA-SALINE"), "Enter dates as quote-wrapped character strings in YYYY-MM-DD format")
  
})

test_that("mdl_handling inputs are sane", {
  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()
  
  expect_error(cleanwq(getwq("FLAB01", "2014-09-14", "2014-09-18", "NITRATE+NITRITE-N", raw = TRUE), mdl_handling = "crazy"), "mdl_handling must be one of 'raw', 'half', or 'full'")
})
