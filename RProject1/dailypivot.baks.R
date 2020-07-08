library(quantmod)
library(dplyr)
if (!exists("foo", mode = "function")) source("envtest.R")
if (!exists("foo1", mode = "function")) source("Script2.R")

argsList <- args
tickers <- c('^GSPC', 'SDS', 'SSO', '^VIX')
getVols <- function(x) {
    m <- as.matrix(x)

    temp <- c(0, diff(log(m[, c('Close')])))

    df <- as.data.frame(cbind(m, temp))
    df <- mutate(df, PCHG = temp * 100)
    df$AvgRet <- rollapply(df$PCHG, 20, mean, fill = NA, align = 'right')
    df$SD20 <- runSD(n = 20, df$PCHG)
    
    df <- mutate(df, ProbRet = pnorm(PCHG, mean = AvgRet, sd = SD20, lower.tail = TRUE) * 100)
    mret <- df[, c('PCHG', 'AvgRet', 'SD20', 'ProbRet')]
    return (as.matrix(mret))
    
}
processVols<- function(y, s) { 
    
    

    


print(s)

y$DailyRet <- dailyReturn(y)
y$AvgRet <- rollapply(y$DailyRet, 20, mean, fill = NA, align = 'right')
y$SD20<- runSD(n = 20, y$DailyRet)
y$VolAnnal <- runSD(n = 20, y$DailyRet) * sqrt(252)
    

    df <- as.data.frame(as.xts(y))
    df = mutate(df, ProbRet = pnorm(DailyRet, mean = AvgRet, sd = SD20, lower.tail = TRUE) * 100)
    
    
    colnames(df)[1] <- 'Open'
    colnames(df)[2] <- 'High'
    colnames(df)[3] <- 'Low'
    colnames(df)[4] <- 'Close'
    fname =paste(s,"-Vols.txt", sep ="")
write.csv(df, fname)


mOHLC = getOHLC(df)
mp <- getAllPivots(mOHLC)
mfinal <- cbind(mOHLC, mp)
write.csv(mfinal, paste(s, "-Pivots.txt", sep = ""))
    write.csv(df, 'df1.txt')
    }




dfall <- NULL
dfall <- NULL
for (asset in tickers) {
    y <- getSymbols(asset, src = 'yahoo', from = '2018-01-01', auto.assign = FALSE)
    processVols(y, asset)
    
    mydf <- as.data.frame(y)   
    names(mydf) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
  #getVols(getOHLC(mydf))
    mydf$symbol <- asset
    mydf$time <- time(y)

    if (is.null(dfall)) {
        dfall <- mydf
    } else {
        dfall <- rbind(dfall, mydf)
    }

}

write.csv(dfall, 'dfall.txt')

