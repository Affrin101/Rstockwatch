#' Calculates daily percentage change of a stock price within a given period of time
#'
#' @param stock_ticker
#' @param start_date
#' @param end_date

percent_change <- function(stock_ticker, start_date, end_date){
	print('TODO')
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
#'
#' @examples
#' volume_viz('AAPL', '2021-01-01', '2022-01-01')
volume_viz <- function(stock_ticker, start_date, end_date){
	print('TODO')
}
