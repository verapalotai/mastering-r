library(binancer)
library(jsonlite)
library(logger)
library(checkmate)
library(scales)
log_threshold(TRACE)

BITCOINS <- 0.42
log_info('Number of Bitcoins: {BITCOINS}') # glue

get_bitcoin_price <- function() {
  tryCatch(
    btcusd <- binance_coins_prices()[symbol == 'BTC', usd],
    error = function(e) get_bitcoin_price()
  )
}

forint <- function(x){
  dollar(x, prefix='', suffix=' Ft')
}

btcusd <- get_bitcoin_price()
log_info('The value of 1 Bitcoin: {dollar(btcusd)}')
asset_number(btcusd, lower=1000)

usdhuf <- fromJSON(readLines('https://api.exchangeratesapi.io/latest?base=USD&symbols=HUF'))$rates$HUF
log_info('The value of 1 USD: {forint(usdhuf)}')
asset_number(usdhuf, lower=250, upper=500)

log_eval(forint(BITCOINS * btcusd * usdhuf)) # TODO formatting