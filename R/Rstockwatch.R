percent_change("AAPL", "2017-01-01", "2017-01-10")


#' Visualizes trend of a stock price change against the market benchmark within a given period of time
#'
#' @param stock_ticker A string Ticker of the stock such as 'AAPL'
#' @param start_date A date in string format of "YYYY-MM-DD" related to start of data extraction
#' @param end_date A date in string format of "YYYY-MM-DD" related to end of data extraction
#' @param benchmark_ticker A string Benchmark Ticker of the stock such as 'SPY'
#'
#' @return A line plot showing the profit percent trend of the stock price change against the market benchmark within a given period of time
#' @export
#'
#' @examples
#'         profit_viz('AAPL', '2017-01-01', '2017-01-10','SPY')
profit_viz <- function(stock_ticker, start_date, end_date, benchmark_ticker){
	print('TODO')
}


#' Calculates the daily trading volume change status of a stock within a given period of time
#'
#' @param stock_ticker A string related to ticker of the stock or ETF
#' @param start_date A date in string format of "YYYY-MM-DD" related to start of data extraction
#' @param end_date A date in string format of "YYYY-MM-DD" related to end of data extraction
#'
#' @return A data frame with dates and their corresponding trading volume and changes
#' @export
#'
#' @examples
#'         volume_change('AAPL', '2017-01-01', '2017-01-10')
volume_change <- function(stock_ticker, start_date, end_date){
	print('TODO')
}


#' Visualizes the daily trading volume of a stock using bar plot within a given period of time
#'
#' @param stock_ticker A string related to ticker of the stock or ETF
#' @param start_date A date in string format of "YYYY-MM-DD" related to start of data extraction
#' @param end_date A date in string format of "YYYY-MM-DD" related to end of data extraction
#'
#' @return A bar plot with trading volumes
#' @export
#'
#' @examples
#'         volume_viz('AAPL', '2017-01-01', '2017-01-10')
volume_viz <- function(stock_ticker, start_date, end_date){
	print('TODO')
}
