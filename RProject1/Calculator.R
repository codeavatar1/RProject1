sp500 <-2634
vix <- 68
hourlyvix <- vix / (252 * 12) ** 0.5
hrrange <- (sp500 * hourlyvix) / 100
hrrange
min5vix <- vix / (252 * 12 * 12) ** 0.5
min5range <- (sp500 * min5vix) / 100
min5range


