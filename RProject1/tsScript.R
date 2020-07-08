#test this scrip

library(quantmod)
library(dplyr)
esu720 <- read.csv(file    = "ESU19.csv")
nrow(esu720)

tickers <- c('^GSPC', 'SDS', 'SSO','^VIX')

getSymbols(tickers, src = 'yahoo', from = '2018-01-01')
write.zoo(GSPC, file = "GSPC1.csv", sep = ",")
setSymbolLookup(GSPC1 = list(src = "csv", format = "%Y-%m-%d"))
setSymbolLookup(ESU19 = list(src = "csv", format = "%d/%m/%Y"))
#ESU19 <- getSymbols("ESU19", auto.assign = FALSE)
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
ncol(esu720)
colnames(esu720)
nrow(esu720)
f1 <- filter(esu720, Time == '05:00')
nrow(f1)
esu720$DateTime <- paste(esu720$Date, esu720$Time, sep = ' ')
rowIndex <- as.POSIXlt(esu720$DateTime, tz = "", format = "%m/%d/%Y %H:%M")
mdata <- as.matrix(esu720[, c('Open', 'High', 'Low', 'Close')])
ts1 <- xts(mdata, order.by = rowIndex)

nrow(ts1)
dailyReturn(ts1)
periodicity(ts1)
dts1 <-as.data.frame(ts1)

dts1 <- mutate(dts1, pctchg = dailyReturn(ts1) * 100)
colnames(dts1)
dts1$pctchg
argsList <- commandArgs()
nrow(argsList)

