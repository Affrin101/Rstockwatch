
# Test for percent change function
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

# Test for checking output of profit viz
results <- profit_viz("AAPL", "2017-01-01", "2022-01-10", "MSFT")

test_that('Plot should use GeomLine and map Date to x-axis and map value to y-axis ', {
  expect_true( "GeomLine" %in% class(results$layers[[1]]$geom))    # profit_viz should be line chart
  expect_true("Date" == rlang::get_expr(results$mapping$x))        # X axis should correspond to "Date"
  expect_true("value" == rlang::get_expr(results$mapping$y))       # Y axis should correspond to "value"
})

# Test for checking output of checking correct labels of profit viz output
test_that('The labels are not mapped correctly', {
  expect_true("Date"== results$label$x)                             # x axis should have label to "Date"
  expect_true("Profit Percent" == results$label$y)                  # Y axis should have label to "Profit Percent"
  expect_true("Line chart of Stock Ticker vs Benchmark Ticker" == results$label$title)  #Title should match
  expect_true("variable" == results$label$colour)
})

# Test for checking output of volume change
test_that("volume change returns a data frame with correct information", {
    vdf <- volume_change('AAPL', '2017-01-01', '2017-01-10')
    expect_true(is.data.frame(vdf))  # Input data should be dataframe
    expect_true("date" %in% colnames(vdf))
    expect_true("volume" %in% colnames(vdf))
    expect_true("Price_change" %in% colnames(vdf))
    unique(vdf[["Price_change"]]) %in% c(NA, "Increase", "Decrease")
  })

# Test for Volume Visualization
test_that("volume_viz is correct", {
  vdf <- volume_change('AAPL', '2017-01-01', '2017-01-10')  #Initialize sample of input data based on another function
  expect_true(is.data.frame(vdf))  # Input data should be dataframe
  expect_true("date" %in% colnames(vdf))
  expect_true("volume" %in% colnames(vdf))
  expect_true("Price_change" %in% colnames(vdf))

  vol_plot <- volume_viz('AAPL', '2017-01-01', '2017-01-10')         # sample plot with a few data
  expect_true("GeomBar" %in% c(class(vol_plot$layers[[1]]$geom)))    # Volumevisualization should be bar chart
  expect_true("date"  == rlang::get_expr(vol_plot$mapping$x))        # X axis should correspond to "date"
  expect_true("volume" == rlang::get_expr(vol_plot$mapping$y))       # Y axis should correspond to "volume"
  expect_true("Price_change"  == rlang::get_expr(vol_plot$mapping$fill))   # Bars should be colored by "Price change"
  expect_true("Price_change" == rlang::get_expr(vol_plot$mapping$colour))  # Bars should be colored by "Price change"
})
