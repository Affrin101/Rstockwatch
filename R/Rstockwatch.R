library(tidyverse)
library(tidyquant)
library(reshape2)

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
#' @param stock_ticker A string related to ticker of the stock or ETF, such as "AAPL"
#' @param start_date A date in string format of "YYYY-MM-DD" related to start of data extraction
#' @param end_date A date in string format of "YYYY-MM-DD" related to end of data extraction
#' @param benchmark_ticker A string Benchmark Ticker of the stock such as 'SPY'
#'
#' @return A line plot showing the profit percent trend of the stock price change against the market benchmark within a given period of time
#' @export
#'
#' @examples
#'         profit_viz('AAPL', '2017-01-01', '2022-01-10','SPY')
profit_viz <- function(stock_ticker, start_date, end_date, benchmark_ticker){
  #Exception handling for input datatypes

  if (!is.character(stock_ticker)) {
    stop("stock_ticker should be a string!")
  }

  if (!is.character(benchmark_ticker)) {
    stop("benchmark_ticker should be a string!")
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


  profit_stock <- percent_change(stock_ticker, start_date, end_date)

  profit_bm <-  percent_change(benchmark_ticker, start_date, end_date)

  profit <- merge(profit_stock, profit_bm, by="date")
  colnames(profit) <- c("Date", "StockProfit", "BenchmarkProfit")

  profit <- melt(profit, id.vars="Date")

  if (!is.data.frame(profit)) {
    stop("profit should be a DataFrame!")
  }

  options(repr.plot.width=15, repr.plot.height=8)

  profit_plot <- ggplot(data=profit, aes(x=Date, y= value, colour = variable)) +
    geom_line() +
    scale_colour_manual(values=c("firebrick2", "darkgreen")) +
    scale_fill_manual(values=c("firebrick2", "darkgreen")) +
    scale_size(range = c(0, 100)) +
    ggtitle('Line chart of Stock Ticker vs Benchmark Ticker') +
    labs(x = 'Date',
         y = "Profit Percent") +
    theme(text = element_text(size=20),
          plot.background = element_rect(fill = 'white', colour = 'white'),
          panel.background = element_rect(fill = "white",
                                          colour = "white"))
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
  
  # Import data
  data <- tq_get(stock_ticker,
                 from = start_date,
                 to = end_date,
                 get = "stock.prices")  %>% 
    mutate(adjusted.prior = lag(adjusted)) %>% 
    mutate(Price_change = adjusted - adjusted.prior) %>% 
    mutate(Price_change = ifelse(Price_change > 0, "Increase", "Decrease")) %>% 
    select(date, volume, Price_change)
    
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
volume_viz <- function(stock_ticker, start_date, end_date){
    # Check input
    dfout <- tryCatch(volume_change(stock_ticker, start_date, end_date), 
                      error = return('Something wrong with input from volume_change function'))
    if(!is.numeric(dfout$volume)) {
        stop("Volume data should be numeric")}   
    
    options(repr.plot.width=15, repr.plot.height=8)
    volume_plot <- ggplot(data=dfout, 
                          aes(x=date, y=volume, fill=Price_change, color=Price_change)) +
    geom_bar(stat="identity", position ="identity") +
    scale_colour_manual(values=c("firebrick2", "darkgreen")) +
    scale_fill_manual(values=c("firebrick2", "darkgreen")) + 
    labs(x = '',
         y = "Volume") +
    theme(text = element_text(size=20), 
          plot.background = element_rect(fill = 'white', colour = 'white'), 
          panel.background = element_rect(fill = "white",colour = "white"))
    
    return(volume_plot)
