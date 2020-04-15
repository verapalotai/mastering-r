## task 1

library(binancer)

btcusd <- binance_coins_prices()[symbol == 'BTC', usd]

## task 2

library(jsonlite)

usdhuf <- fromJSON(readLines('https://api.exchangeratesapi.io/latest?base=USD&symbols=HUF'))$rates$HUF

results <- btcusd*usdhuf*0.42
