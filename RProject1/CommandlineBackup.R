library(sqldf)

library(RH2)
library(quantmod)
library('stringr')
library('zoo')
library(dplyr)




e <- globalenv()
e.prod <- 0
if (e.prod) setwd('C:\\Users\\bvh8924\\Scripts\\')
wd <- getwd()



e$scriptDir <- paste(wd, "\\", sep = "")
source(paste(e$scriptDir, 'envall.R', sep = ""), echo = FALSE)

if (!exists("foo", mode = "function")) source(paste(e$prodDir, 'myFUN.R', sep = ''), echo =FALSE )


tickers <- c('^GSPC', 'SDS', 'SSO', '^VIX')

getSymbols(tickers, src = 'yahoo', from = '2018-01-01')

params <- commandArgs(trailingOnly = TRUE)
print(params)

fname <- "Esz19 November19 Daily.txt"
fname <-paste(e$onedriveDir,fname , sep = "")
ds <- read.csv(file = fname, header = TRUE)
ds$DateTime <- paste(ds$Date, ds$Time, sep = ' ')
mdata <- as.matrix(ds[, c('Open', 'High', 'Low', 'Close')])
rowIndex <- as.POSIXlt(ds$DateTime, tz = "", format = "%m/%d/%Y %H:%M")
ts1 <- xts(mdata, order.by = rowIndex)
dataPeriod <- as.character(periodicity(ts1))
dataPeriod1 <- as.vector(periodicity(ts1))
print(dataPeriod1)
 
          
setSymbolLookup(GSPC1 = list(src = "csv", format = "%Y-%m-%d"))
setSymbolLookup(ESU19 = list(src = "csv", format = "%d/%m/%Y"))
GSPC1 <- getSymbols("GSPC1", auto.assign = FALSE)
nrow(GSPC1)
nrow(GSPC)
ncol(GSPC)
typeof(GSPC)
class(GSPC)
colnames(GSPC)

DailyRet <- dailyReturn(GSPC1)
ind1 <- cbind(GSPC, DailyRet)
#sd <- runSD(n = 20, ind1$daily.returns) * sqrt(252)

colnames(ind1)
max(GSPC1[, 2])
min(GSPC[1:20, 3])
#GSPC1[nrow(GSPC1)]
#ind1$ATRstop <- ATR(HLC(GSPC), 5)
#ind1[nrow(ind1)]
#ATR(HLC(GSPC), 5)
#write.csv(ind1, file = 'ind1.txt')
#mutate(SMA_wins = rollapplyr(wins, 3, mean, partial = TRUE))
params
set.seed(42)
t1 <- replicate(25, rnorm(100))
nrow(t1)

#t1[, 5]
sample_n(ds, 5)


stats <- apply(t1, 2, function(x) c('mean' = mean(x), 'sd' = sd(x)))
#stats

x <- t1[, 8]
#sqldf("select stddev_pop(x), stddev_samp(x) from X")
x <-sample_n(ds, 5)
xclose <- x[, c('Close')]
#xclose
#stats <- apply(xclose, 2, function(x) c('mean' = mean(x), 'sd' = sd(x)))

#sd(xclose)
ts1returns <- dailyReturn(ts1) * 100
periodReturn(ts1, 3)

Calculating a Confidence Interval From a t Distribution
Calculating the confidence interval when using a t - test is similar to using a normal distribution. The only difference is that we use the command associated with the t - distribution rather than the normal distribution. Here we repeat the procedures above, but we will assume that we are working with a sample standard deviation rather than an exact standard deviation.
Again we assume that the sample mean is 5, the sample standard deviation is 2, and the sample size is 20. We use a 95 % confidence level and wish to find the confidence interval. The commands to find the confidence interval in R are the following:
    > a <- 5
> s <- 2
> n <- 20
> error <- qt(0.975, df = n - 1) * s / sqrt(n)
> left <- a - error
> right <- a + error
> left
[1] 4.063971
> right
[1] 5.936029
Our level of certainty about the true mean is 95 % in predicting that the true mean is within the interval between 4.06 and 5.94 assuming that the original random variable is normally distributed, and the samples are independent.


