context("get_hydro")

test_that("ge_thydro works", {
  skip_on_cran()
  
  expect_is(get_hydro(dbkey = "15081", date_min = "2013-01-01",
    date_max = "2013-02-02"), "data.frame")
  
  get_hydro(dbkey = c("15081", "15069"), date_min = "2013-01-01",
    date_max = "2013-02-02")
  
})

test_that("get_hydro fails well", {
  skip_on_cran()
  
  expect_error(get_hydro(dbkey = "15081", date_min = "1980-01-01",
    date_max = "1980-02-02"), "No data found")
  
})

test_that("non-character dates are handled", {
  skip_on_cran()
  
  expect_error(get_hydro(dbkey = "15081", date_min = 1980-01-01,
    date_max = "1980-02-02"),
    "Enter dates as quote-wrapped character strings in YYYY-MM-DD format")
  
})
