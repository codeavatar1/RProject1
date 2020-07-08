#test this scrip
#install.packages('devtools')
#install.packages('QUANTMOD')

#devtools::install_github("joshuaulrich/quantmod")
#devtools::install_github("                                                                                                                fjoshuaulrich/quantmod", ref = "157_yahoo_502")
devtools::install_github("joshuaulrich/quantmod", ref = "157_yahoo_502")

library(quantmod)
library(dplyr)
tickers <- c('^GSPC', 'SDS', 'SSO','^VIX')

getSymbols(tickers, src = 'yahoo', from = '2018-01-01')
write.zoo(GSPC, file = "GSPC1.csv", sep = ",")
setSymbolLookup(GSPC1 = list(src = "csv", format = "%Y-%m-%d"))
GSPC1 <- getSymbols("GSPC1", auto.assign = FALSE)
nrow(GSPC1)




nrow(GSPC)
ncol(GSPC)
typeof(GSPC)
class(GSPC)
colnames(GSPC)

DailyRet <- dailyReturn(GSPC)
ind1 <- cbind(GSPC, DailyRet)
sd  <- runSD(n = 20, ind1$daily.returns) * sqrt(252)

colnames(ind1)      
max(GSPC[, 2])
min(GSPC[1:20, 3])
GSPC[nrow(GSPC)]
ind1$ATRstop <- ATR(HLC(GSPC), 5)
ind1[nrow(ind1)]
#ATR(HLC(GSPC), 5)
write.csv(ind1, file = 'ind1.txt')
#mutate(SMA_wins = rollapplyr(wins, 3, mean, partial = TRUE))
as.data.frame(logback <- read.table(file = 'logback.out', sep = "\n"))
colnames(logback) <-c('Col1')


                      nrow(logback)
ncol(logback)

df2 <- filter(logback, grepl("*Price*", Col1))

write.table(df2, file = 'df2.txt')


