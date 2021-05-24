
test_that("get_hydro works", {
  vcr::use_cassette("get_hydro_works_single", {
    x <- get_hydro(dbkey = "15081", date_min = "2013-01-01",
                   date_max = "2013-02-02")
  })
  expect_s3_class(x, "data.frame")

  vcr::use_cassette("get_hydro_works_multiple", {
    x <- get_hydro(dbkey = c("15081", "15069"), date_min = "2013-01-01",
                   date_max = "2013-02-02")
  })
  expect_s3_class(x, "data.frame")
})

vcr::use_cassette("get_hydro_fails", {
  test_that("get_hydro fails well", {
    expect_error(
      get_hydro(dbkey = "15081", date_min = "1980-01-01",
                           date_max = "1980-02-02"),
      "No data found")
  })
})

test_that("non-character dates are handled", {
    expect_error(
      get_hydro(dbkey = "15081", date_min = 1980-01-01,
                date_max = "1980-02-02"),
      "Enter dates as quote-wrapped character strings in YYYY-MM-DD format")
})


test_that("get_hydro retrieves dbkeys on-the-fly", {
  vcr::use_cassette("fly_dbykeys_single", {
    x <- get_hydro(stationid = "C-54", category = "GW",
                        freq = "DA", date_min = "1990-01-01", date_max = "1990-02-02",
                        longest = TRUE)
  })
  expect_equal(ncol(x), 2)

  vcr::use_cassette("fly_dbykeys_multiple", {
    x <- get_hydro(stationid = c("C-54", "G-561"),
                   category = "GW", freq = "DA",
                   date_min = "1990-01-01", date_max = "1990-02-02",
                   longest = TRUE)
  })
  expect_equal(ncol(x), 3)
})
