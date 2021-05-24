
test_that("get_wq works", {
  vcr::use_cassette("get_wq_works", {
  x <- get_wq(station_id = c("FLAB08", "FLAB09"),
         date_min = "2011-03-01", date_max = "2012-05-01",
         test_name = "CHLOROPHYLL-A, SALINE")
  })
  expect_s3_class(x, "data.frame")
})

vcr::use_cassette("get_wq_fails_well", {
test_that("get_wq fails well", {
  expect_message(get_wq(station_id = c("FLAB08", "FLAB09"),
                        date_min = "1990-03-01", date_max = "1992-05-01",
                        test_name = "CHLOROPHYLL-A, SALINE"),
                 "No data found")

  expect_message(get_wq(station_id = "ROOK467", date_min = "2012-07-19",
                        date_max = "2016-04-27", test_name = "AMMONIA-N"),
                 "No data found")

  expect_message(get_wq("FLAB01", "1983-09-14", "1986-09-18",
                        "NITRATE+NITRITE-N", raw = TRUE),
                 "No data found")
  })
})

test_that("non-character dates are handled", {
    expect_error(
      get_wq(station_id = c("FLAB08", "FLAB09"), date_min = 1990-03-01,
             date_max = 1992-05-01, test_name = "CHLOROPHYLL-A, SALINE"),
      "Enter dates as quote-wrapped character strings in YYYY-MM-DD format")
})


test_that("mdl_handling inputs are sane", {
    expect_error(
      clean_wq(get_wq("FLAB01", "2014-09-14", "2014-09-18",
                      "NITRATE+NITRITE-N", raw = TRUE), mdl_handling = "crazy"),
      "mdl_handling must be one of 'raw', 'half', or 'full'")
})


test_that("mdl handling occurs when get_wq raw is TRUE", {
  vcr::use_cassette("get_mdl_handling_raw", {
    yes_raw <- get_wq("FLAB01", "2014-09-14", "2014-09-18", "NITRATE+NITRITE-N",
                      raw = TRUE, mdl_handling='half')$Value
    no_raw <- get_wq("FLAB01", "2014-09-14", "2014-09-18", "NITRATE+NITRITE-N",
                     raw = FALSE, mdl_handling='half')[,2]
  })
  expect_equal(yes_raw, no_raw)
})

test_that("multiple stations return correct num of columns", {
  vcr::use_cassette("get_wq_multiple_stations", {
    x <- ncol(get_wq(station_id = c("FLAB08","FLAB09"),
                     date_min = "2011-03-01", date_max = "2012-05-01",
                     test_name = "CHLOROPHYLL-A, SALINE"))
  })
  expect_equal(x, 3)
})
