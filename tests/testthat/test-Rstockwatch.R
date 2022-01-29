# Test input stock ticker
test_that("Error of stock_ticker", {
  expect_error(percent_change("ABCD", "2017-01-01", "2017-01-10"))
})

# Test start_date format
test_that("Error of start_date format", {
  expect_error(percent_change("AAPL", "20170101", "2017-01-10"))
})

# Test end_date format
test_that("Error of end_date format", {
  expect_error(percent_change("AAPL", "2017-01-01", "2017/01/10"))
})

# Test output is data frame
test_that("Output is a data frame", {
  expect_true(is.data.frame(percent_change("AAPL", "2017-01-01", "2017-01-10")))
})

# Test percent_change column is numeric value
test_that("percent_change is numeric value", {
  expect_true(is.numeric(percent_change("AAPL", "2017-01-01", "2017-01-10")$percent_change))
})