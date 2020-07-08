library(quantmod)
library(dplyr)
if (!exists("foo", mode = "function")) source("envtest.R")
if (!exists("foo1", mode = "function")) source("Script2.R")

argsList <- args
tickers <- c('^GSPC', 'SDS', 'SSO', '^VIX')
lsymbols <- data.frame(tickers)
getSymbols(tickers, src = 'yahoo', from = '2018-01-01')

processTicker <- function(x) { 
    
    print(x)
ind1 <- GSPC


ind1$DailyRet <- dailyReturn(GSPC)
ind1$AvgRet <- rollapply(ind1$DailyRet, 20, mean, fill = NA, align = 'right')
ind1$SD20<- runSD(n = 20, ind1$DailyRet)
ind1$VolAnnal <- runSD(n = 20, ind1$DailyRet) * sqrt(252)


df1 <- as.data.frame(as.xts(ind1))
pDailyRet = mutate(df1, PDailyRet = pnorm(DailyRet, mean = AvgRet, sd = SD20, lower.tail = TRUE) * 100)
write.csv(pDailyRet, "GSPCVol.txt")

colnames(df1)[1] <- 'Open'
colnames(df1)[2] <- 'High'
colnames(df1)[3] <- 'Low'
colnames(df1)[4] <- 'Close'
mOHLC = getOHLC(df1)
mp <- getAllPivots(mOHLC)
mfinal <- cbind(mOHLC, mp)
write.csv(mfinal, paste(ticker1, "-Pivosts", ".txt", sep = ""))
    write.csv(df1, 'df1.txt')
}

for (i in 1 :length(lsymbols))processTicker(lsymbols[i])
