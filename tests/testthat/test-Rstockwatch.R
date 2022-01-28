





test_that("volume_viz is correct", {
  vol_plot <- volume_viz('AAPL', '2017-01-01', '2017-01-10')         # sample plot with a few data
  
  expect_true("GeomBar" %in% c(class(vol_plot$layers[[1]]$geom)))    # Volumevisualization should be bar chart
  expect_true("date"  == rlang::get_expr(vol_plot$mapping$x))        # X axis should correspond to "date"
  expect_true("volume" == rlang::get_expr(vol_plot$mapping$y))       # Y axis should correspond to "volume"
  expect_true("Price_change"  == rlang::get_expr(vol_plot$mapping$fill))   # Bars should be colored by "Price change"
  expect_true("Price_change" == rlang::get_expr(vol_plot$mapping$colour))  # Bars should be colored by "Price change"
  
})