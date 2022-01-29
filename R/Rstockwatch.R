library(tidyverse)
library(tidyquant)

#' Calculates daily percentage change of a stock price within a given period of time
#'
#' @param stock_ticker Ticker of the stock such as 'AAPL'
#' @param start_date Initial date for data extraction
#' @param end_date Final date for stock analysis
#'
#' @return A data frame with dates and their corresponding stock price percentage changes
#' @export
#'
#' @examples
#'         percent_change("AAPL", "2017-01-01", "2017-01-10")
#'                     Price Change Percentage(%)
#'               Date
#'         2017-01-03                        0.00
#'         2017-01-04                       -0.11
#'         2017-01-05                        0.40
#'         2017-01-06                        1.52
#'         2017-01-09                        2.45
percent_change <- function(stock_ticker, start_date, end_date){  
  # Check if stock_ticker is valid in SP500 index
  sp600_tickers_list <- c(tq_index("SP500")$symbol)
  
  if(str_detect(stock_ticker, "[[:upper:]]") == FALSE){
    stock_ticker <- toupper(stock_ticker)
  }
  
  if(!stock_ticker %in% sp600_tickers_list) {
    stop("Invalid stock_ticker! Try a different one. All letters should be either all in upper case or all in lower case")
  }

  # Check if date is in correct time format
  # start_date
  if(is.na(as.Date(start_date, format = '%Y-%m-%d'))) {
		stop("Invalid start date! Start date should be in format yyyy-mm-dd")
  }
  # end_date
  if(is.na(as.Date(end_date, format = '%Y-%m-%d'))) {
		stop("Invalid end date! End date should be in format yyyy-mm-dd")
  }

  # Import data frame
  data <- tq_get(stock_ticker,
               from = start_date,
               to = end_date,
               get = "stock.prices")
  
  # Calculate percent_change value based on close price
  percent_change_list <- c()

  for (i in 1:length(data$close)) {
    out = (data$close[i] - data$close[1])/data$close[1]
    percent_change_list <- c(percent_change_list, round(out, 3))
  }

  data$percent_change <- percent_change_list
  
  # Only keep columns of date and percent_change
  data <- data |> 
    select(date, percent_change)
  
  return(data)
}


#' Visualizes trend of a stock price change against the market benchmark within a given period of time
#'
#' @param stock_ticker
#' @param start_date
#' @param end_date
#' @param benchmark_ticker
profit_viz <- function(stock_ticker, start_date, end_date, benchmark_ticker){
	print('TODO')
}


#' Calculates the daily trading volume change status of a stock within a given period of time
#'
#' @param stock_ticker
#' @param start_date
#' @param end_date
volume_change <- function(stock_ticker, start_date, end_date){
	print('TODO')
}


#' Visualizes the daily trading volume of a stock using bar plot within a given period of time
#'
#' @param stock_ticker A string related to ticker of the stock or ETF
#' @param start_date A date in string format of "YYYY-MM-DD" related to start of data extraction
#' @param end_date A date in string format of "YYYY-MM-DD" related to end of data extraction
#' @return A bar plot with trading volumes
volume_viz <- function(stock_ticker, start_date, end_date){
	print('TODO')
}
