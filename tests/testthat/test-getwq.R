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