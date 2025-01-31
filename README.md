
<!-- README.md is generated from README.Rmd. Please edit README.Rmd file -->

# Rstockwatch

<!-- badges: start -->

[![R-CMD-check](https://github.com/UBC-MDS/Rstockwatch/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/Rstockwatch/actions)[![codecov](https://codecov.io/gh/UBC-MDS/Rstockwatch/branch/main/graph/badge.svg?token=ylGvMBscyC)](https://codecov.io/gh/UBC-MDS/Rstockwatch)

<!-- badges: end -->

The goal of Rstockwatch package is to provide a very simple interface
for checking movements in stock prices in comparison to the market. This
is implemented by accessing public data from Yahoo Finance by selecting
a ticker of the stock, range of start and end dates and benchmark for
comparison, such as SP500 or NASDAQ. As a result of data processing with
Rstockwatch package, user will be able to see a plot with two lines
showing percentage change since the start date and volumes of trading.

## Functions

This package is built with following four functions:  
- `percent_change` Calculation of profit percentage change of a stock
for a given period of time based on data extracted from Yahoo finance.  
- `profit_viz` Visualization of profit percentage change trend of a
stock against market benchmark for a given period of time. Note that
during weekends and public holidays, stock market has no data available,
this is handled in plotting as well  
- `volume_change` Calculation of daily trading volume change of a stock,
whether it is increasing or decreasing. This data is used in next
function for color mapping of bar plot.  
- `volume_viz` Visualization of trading volume as bar plots colored by
changes in volume in comparison with previous day. This plot is
overlayed with line plots created with the second function. . Note that
during weekends and public holidays, stock market has no data available,
this is handled in plotting as well

## Comparison with similar packages in R Ecosystem

There are many packages written for analysis of stock data. One of
relevant R package in this category is
[quantmod](https://cran.r-project.org/web/packages/quantmod), which
allows a lot of manipulations with time series data, such as creating
moving averages or calculating other parameters for technical analysis.
Power of `Rstockwatch` is in its simplicity, so users are not
overwhelmed with all extra features and just have a simple view with key
comparisons for a stock of interest

## Installation

You can install the development version from
[GitHub](https://github.com/UBC-MDS/Rstockwatch) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/Rstockwatch")
```

## Usage and Example

After the successful installation of this package user are recommend to
restart the R session to update any dependencies packages. The functions
in this package require input four parameters: `stock_ticker`,
`start_date`, `end_date` and `benchmark_ticker`. Output results are in
form of an plot based on “ggplot” package.

Import the functions from package with following commands:

    library(Rstockwatch)

### To check the Profit percent

    percent_change('AAPL', '2017-01-01', '2021-12-31')

### To Visualize the profit percentage change trend of a stock against market benchmark

    profit_viz('AAPL', '2015-01-01', '2021-12-31', 'SPY')

![Profit
visualization](https://github.com/UBC-MDS/Rstockwatch/blob/main/docs/reference/profit_viz-1.png)

### To check daily trading volume change of a stock

    volume_change('AAPL', '2021-01-01', '2021-12-31')

### To Visualize the volume change trend of a stock

    volume_viz('AAPL', '2021-01-01', '2021-12-31')

![Volume
visualization](https://github.com/UBC-MDS/Rstockwatch/blob/main/docs/reference/volume_viz-1.png)

## Documentation

A more detailed information about our package can found seen on the
vignette
[here](https://ubc-mds.github.io/Rstockwatch/articles/my-vignette.html)

## Contributors

-   Affrin Sultana
-   Helin Wang
-   Pavel Levchenko
-   Shi Yan Wang

We welcome and recognize all contributions. Check out the contributing
guidelines. Please note that this project is released with a Code of
Conduct. By contributing to this project, you agree to abide by its
terms.

## Dependencies

-   R Version 4.1 or above

    > tidyverse==1.3.1

    > knitr==1.36

    > testthat (>= 3.0.0)

    > ggplot2 ==3.3.5

    > tidyquant ==1.0.3

## License

`Rstockwatch` was created by Affrin Sultana, Helin Wang, Pavel
Levchenko, Shi Yan Wang. It is licensed under the terms of the MIT
license.
