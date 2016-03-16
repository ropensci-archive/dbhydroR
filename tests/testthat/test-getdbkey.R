context("getdbkey")

test_that("getdbkey fails well", {
  skip_on_cran()
  skip_on_travis()
  skip_on_appveyor()
  
  expect_error(getdbkey(stationid = "S152%", category = "SW") , "No dbkeys found")
  
})