#' Calculates daily percentage change of a stock price within a given period of time
#'
#' @param stock_ticker A string related to ticker of the stock or ETF
#' @param start_date A date in string format of "YYYY-MM-DD" related to start of data extraction
#' @param end_date A date in string format of "YYYY-MM-DD" related to end of data extraction
#'
#' @return A data frame with dates and their corresponding stock price percentage changes
#' @export
#'
#' @examples
#'         percent_change('AAPL', '2017-01-01', '2017-01-10')
percent_change <- function(stock_ticker, start_date, end_date){
	print('TODO')
}


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
	df <- tq_get(stock_ticker, from = start_date, to = end_date, get = "stock.prices")
	dfout <- df |>
	   mutate(Price_change=ifelse(c(0,diff(close))<0,"Decrease","Increase"))
	volume_plot <- ggplot(data=dfout, aes(x=date, y=volume, fill=Price_change, color=Price_change)) +
		  geom_bar(stat="identity", position ="identity") +
		  scale_colour_manual(values=c("firebrick2", "darkgreen")) +
		  scale_fill_manual(values=c("firebrick2", "darkgreen")) + 
		  theme_bw()
	return(volume_plot)
}
