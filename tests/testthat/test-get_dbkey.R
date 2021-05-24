
vcr::use_cassette("get_dbkey_fails_well", {
  test_that("get_dbkey fails well", {
    expect_error(
      get_dbkey(stationid = "S152%", category = "GW"),
      "No dbkeys found")
  })
})

test_that("get_dbkey works", {
  vcr::use_cassette("get_dbkey_works_gw", {
    res <- invisible(get_dbkey(stationid = "C111AE", category = "GW",
                               param = "WELL", freq = "DA", stat = "MEAN", strata = c(9, 22),
                               recorder = "TROL", agency = "WMD", detail.level = "full"))
  })
  expect_s3_class(invisible(res), "data.frame")
  expect_equal(nrow(res), 1)

  vcr::use_cassette("get_dbkey_works_weather", {
  res <- get_dbkey(stationid = c("MBTS", "JBTS"), category = "WEATHER",
         param = "WNDS", freq = "DA", detail.level = "dbkey")
  })
  expect_equal(length(res), 2)
})
