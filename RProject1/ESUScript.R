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
setSymbolLookup(ESU19 = list(src = "csv", format = "%d/%m/%Y"))
setSymbolLookup(ESUA19 = list(src = "csv", format = "%d/%m/%Y"))
dfesu19 <- read.csv(file = "esu19.csv")
dfnew <- dfesu19[, c('Date', 'Open', 'High', 'Low', 'Close', 'Vol')]
rownames(dfnew) <- dfnew$ESUA19.Date
colnames(dfnew) <- c('Index','ESUA19.Date', 'ESUA19.Open', 'ESUA19.High', 'ESUA19.Low', 'ESUA19.Close', 'ESUA19.Volume')

write.csv(dfnew, file = "ESUA19.csv")




#esu19 <- getSymbols("ESU19", auto.assign = FALSE)
ESUA19 <- getSymbols("ESUA19", auto.assign = FALSE)

GSPC1 <- getSymbols("GSPC1", auto.assign = FALSE)
nrow(GSPC1)
#nrow(ESU19)




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


nrow(dfesu19)
nrow
(esu19)