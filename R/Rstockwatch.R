#' Calculates daily percentage change of a stock price within a given period of time
#'
#' @param stock_ticker A string related to ticker of the stock or ETF, such as "AAPL"
#' @param start_date A date in string format of "YYYY-MM-DD" related to start of data extraction
#' @param end_date A date in string format of "YYYY-MM-DD" related to end of data extraction
#'
#' @return A data frame with dates and their corresponding stock price percentage changes
#' @export
#'
#' @examples
#' percent_change("AAPL", "2017-01-01", "2017-01-10")
percent_change <- function(stock_ticker, start_date, end_date){
  # Check if stock_ticker is valid in SP500 index
  sp500_tickers_list <- c(tidyquant::tq_index("SP500")$symbol)

  if(stringr::str_detect(stock_ticker, "[[:upper:]]") == FALSE){
    stock_ticker <- toupper(stock_ticker)
  }

  if(!stock_ticker %in% sp500_tickers_list) {
    stop("Invalid stock_ticker! Try a different one. All letters should be either all in upper case or all in lower case")
  }
  # Check start date
  if(is.na(as.Date(start_date, format = '%Y-%m-%d'))) {
		stop("Invalid start date! Start date should be in format yyyy-mm-dd")
  }
  # Check end date
  if(is.na(as.Date(end_date, format = '%Y-%m-%d'))) {
		stop("Invalid end date! End date should be in format yyyy-mm-dd")
  }

  if (as.Date(end_date, format = '%Y-%m-%d') < as.Date(start_date, format = '%Y-%m-%d')) {
    stop("Invalid values: start_date should be smaller or equal to end_date")
  }

  # Import data frame
  data <-  tidyquant::tq_get(stock_ticker,
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
       dplyr::select(date, percent_change)
#
   return(data)
}

#' Visualizes trend of a stock price change against the market benchmark within a given period of time
#'
#' @param stock_ticker A string related to ticker of the stock or ETF, such as "AAPL"
#' @param start_date A date in string format of "YYYY-MM-DD" related to start of data extraction
#' @param end_date A date in string format of "YYYY-MM-DD" related to end of data extraction
#' @param benchmark_ticker A string Benchmark Ticker of the stock such as 'SPY'
#'
#' @return A line plot showing the profit percent trend of the stock price change against the market benchmark within a given period of time
#' @export
#'
#' @examples
#'         profit_viz('AAPL', '2017-01-01', '2022-01-10','MSFT')
#'
profit_viz <- function(stock_ticker, start_date , end_date, benchmark_ticker){

  profit_stock <-percent_change(stock_ticker, start_date, end_date)

  profit_bm <-  percent_change(benchmark_ticker, start_date, end_date)

  profit <- merge(profit_stock, profit_bm, by="date")

  colnames(profit) <- c("Date", "StockProfit", "BenchmarkProfit")

  profit <- reshape2::melt(profit, id.vars="Date")

  options(repr.plot.width=15, repr.plot.height=8)

  profit_plot <- ggplot2::ggplot(data=profit,
                                 ggplot2::aes(x=Date, y= value, colour = variable)) +
    ggplot2::geom_line() +
    ggplot2::scale_colour_manual(values=c("firebrick2", "darkgreen")) +
    ggplot2::scale_fill_manual(values=c("firebrick2", "darkgreen")) +
    ggplot2::scale_size(range = c(0, 100)) +
    ggplot2::ggtitle('Line chart of Stock Ticker vs Benchmark Ticker') +
    ggplot2::labs(x = 'Date',
         y = "Profit Percent")

  return(profit_plot)

}

#' Calculates the daily trading volume change status of a stock within a given period of time
#'
#' @param stock_ticker A string related to ticker of the stock or ETF, such as "AAPL"
#' @param start_date A date in string format of "YYYY-MM-DD" related to start of data extraction
#' @param end_date A date in string format of "YYYY-MM-DD" related to end of data extraction
#'
#' @return A data frame with dates and their corresponding trading volume and changes
#' @export
#'
#' @examples
#'         volume_change('AAPL', '2017-01-01', '2017-01-10')
volume_change <- function(stock_ticker, start_date, end_date){

  # Check if stock_ticker is valid in SP500 index
  tickers_list <- c(tidyquant::tq_index("SP500")$symbol)
  
  if(stringr::str_detect(stock_ticker, "[[:upper:]]") == FALSE){
    stock_ticker <- toupper(stock_ticker)
  }

  if(!stock_ticker %in% tickers_list) {
    stop("Invalid stock_ticker! Try a different one. All letters should be either all in upper case or all in lower case")
  }
  # Check time format
  # Start_date
  if(is.na(as.Date(start_date, format = '%Y-%m-%d'))) {
    stop("Invalid start date! Start date should be in format yyyy-mm-dd")
  }
  # End_date
  if(is.na(as.Date(end_date, format = '%Y-%m-%d'))) {
    stop("Invalid end date! End date should be in format yyyy-mm-dd")
  }
  if (as.Date(end_date, format = '%Y-%m-%d') < as.Date(start_date, format = '%Y-%m-%d')) {
    stop("Invalid values: start_date should be smaller or equal to end_date")
  }

  # Import data
  data <- tidyquant::tq_get(stock_ticker,
                 from = start_date,
                 to = end_date,
                 get = "stock.prices")  |>
    dplyr::mutate(Price_change=ifelse(c(0,diff(close))<0,"Decrease","Increase")) |>
    dplyr::select(date, volume, Price_change)

  return(data)
 
}

#' Visualizes the daily trading volume of a stock using bar plot within a given period of time
#'
#' @param stock_ticker A string related to ticker of the stock or ETF, such as "AAPL"
#' @param start_date A date in string format of "YYYY-MM-DD" related to start of data extraction
#' @param end_date A date in string format of "YYYY-MM-DD" related to end of data extraction
#'
#' @return A bar plot of daily trading volume changes
#' @export
#'
#' @examples
#'         volume_viz('AAPL', '2017-01-01', '2017-01-10')
#'
volume_viz <- function(stock_ticker, start_date, end_date){

  # Check input
  dfout <- volume_change(stock_ticker, start_date, end_date)

  if(!is.numeric(dfout$volume)) {
    stop("Volume data should be numeric")}

  options(repr.plot.width=15, repr.plot.height=8)
  volume_plot <- ggplot2::ggplot(data=dfout,
                                 ggplot2::aes(x=date, y=volume, fill=Price_change, color=Price_change)) +
    ggplot2::geom_bar(stat="identity", position ="identity") +
    ggplot2::scale_colour_manual(values=c("firebrick2", "darkgreen")) +
    ggplot2::scale_fill_manual(values=c("firebrick2", "darkgreen")) +
    ggplot2::labs(x = '',
         y = "Volume")

  return(volume_plot)
}
