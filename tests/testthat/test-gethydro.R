context("gethydro")

test_that("gethydro works", {
  skip_on_cran()
  
  expect_is(gethydro(dbkey = "15081", date_min = "2013-01-01",
    date_max = "2013-02-02"), "data.frame")
  
  gethydro(dbkey = c("15081", "15069"), date_min = "2013-01-01",
    date_max = "2013-02-02")
  
})

test_that("gethydro fails well", {
  skip_on_cran()
  
  expect_error(gethydro(dbkey = "15081", date_min = "1980-01-01",
    date_max = "1980-02-02"), "No data found")
  
})

test_that("non-character dates are handled", {
  skip_on_cran()
  
  expect_error(gethydro(dbkey = "15081", date_min = 1980-01-01,
    date_max = "1980-02-02"),
    "Enter dates as quote-wrapped character strings in YYYY-MM-DD format")
  
})
