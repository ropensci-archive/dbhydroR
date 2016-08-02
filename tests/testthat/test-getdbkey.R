context("getdbkey")

test_that("getdbkey fails well", {
  skip_on_cran()
  
  expect_error(getdbkey(stationid = "S152%", category = "SW"),
    "No dbkeys found")
  
})

test_that("getdbkey works", {
  skip_on_cran()

  res <- invisible(getdbkey(stationid = "C111AE", category = "GW",
         param = "WELL", freq = "DA", stat = "MEAN", strata = c(9, 22),
         recorder = "TROL", agency = "WMD", detail.level = "full"))
  expect_is(invisible(res), "data.frame")
  expect_equal(nrow(res), 1)
  
  res <- getdbkey(stationid = c("MBTS", "JBTS"), category = "WEATHER",
         param = "WNDS", freq = "DA", detail.level = "dbkey")
  expect_equal(length(res), 2)
  
})

