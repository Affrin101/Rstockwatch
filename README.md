
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Rstockwatch

<!-- badges: start -->
<!-- badges: end -->

The goal of Rstockwatch package is to provide a very simple interface
for checking movements in stock prices in comparison to the market. This
is implemented by accessing public data from Yahoo Finance by selecting
a ticker of the stock, range of start and end dates and benchmark for
comparison, such as SP500 or NASDAQ. As a result of data processing with
pystockwatch package, user will be able to see a plot with two lines
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

There are many packages written for analysis of stock data. One of the
most popular R package in this category is
[stockAnalyzer](https://github.com/UBC-MDS/stockAnalyzer), which gives a
lot of manipulations with time series data, such as creating moving
averages of stock price or calculating hundreds of parameters for
technical analysis. Power of `Rstockwatch` is in its simplicity, so
users are not overwhelmed with all extra features and just have a simple
view with key comparisons for a stock of interest

## Installation

You can install the development version from
[GitHub](https://github.com/UBC-MDS/Rstockwatch) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/Rstockwatch")
```

## Example

Usage clarification will be updated after completion of all functions.
In general, after installation of this package user will be required to
input four parameters: stock_ticker, start_date, end_date and
benchmark_ticker. Output results will be in form of an plot based on
“ggplot” package. (Image)(!)

## Contributors

Affrin Sultana, Helin Wang, Pavel Levchenko, Shi Yan Wang.

We welcome and recognize all contributions. Check out the contributing
guidelines. Please note that this project is released with a Code of
Conduct. By contributing to this project, you agree to abide by its
terms.

## Dependencies

-   R Version 4.1 or above

    > tidyverse==1.3.1

    > knitr==1.36

    > testthat (>= 3.0.0)

    > ggplot

## License

`Rstockwatch` was created by Affrin Sultana, Helin Wang, Pavel
Levchenko, Shi Yan Wang. It is licensed under the terms of the MIT
license.
