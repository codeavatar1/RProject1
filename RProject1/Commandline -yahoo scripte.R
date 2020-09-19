library(quantmod)
library('stringr')
library('zoo')
library(dplyr)




e <- globalenv()
e.prod <- 0
if (e.prod) setwd('C:\\Users\\bvh8924\\Scripts\\')
wd <- getwd()
myenv <-e
directory <- myenv$workDir


e$scriptDir <- paste(wd, "\\", sep = "")
source(paste(e$scriptDir, 'envall.R', sep = ""), echo = FALSE)

if (!exists("foo", mode = "function")) source(paste(e$prodDir, 'myFUN.R', sep = ''), echo =FALSE )


symbolslist <- read.csv(file = paste(myenv$tradestationOutDir, "symbols.csv", sep = ''))
s1 <- symbolslist[,1]
s1




getSymbols("NKLA", src = 'yahoo', from = '2018-01-01')


write.zoo(NKLA, file = paste(myenv$tradestationOutDir, "GSPC.txt", sep = ''))

params <- commandArgs(trailingOnly = TRUE)
print(params)

fname <- "Esz19 November19 Daily.txt"
fesdec13min5 <- "esz19 dec18 5min.txt"
fname <- paste(e$onedriveDir, fname, sep = "")
fesdec13min5 <- paste(e$onedriveDir, fesdec13min5 , sep = "")
ds <- read.csv(file = fname, header = TRUE)
desdec13min5 <- read.csv(file = fesdec13min5, header = TRUE)

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

ts1returns <- dailyReturn(ts1) * 100
dts1  <-as.data.frame(ts1returns)
samp30 <- sample_n(dts1, 30)
statsall <- apply(samp30, 2, function(x) c('mean' = mean(x), 'sd' = sd(x)))
samp30 <- sample_n(dts1, 30)
statsall <- cbind(statsall, apply(samp30, 2, function(x) c('mean' = mean(x), 'sd' = sd(x))))
samp30 <- sample_n(dts1, 30)
statsall <- cbind(statsall, apply(samp30, 2, function(x) c('mean' = mean(x), 'sd' = sd(x))))
write.csv(statsall, file ='statsall.txt')
statsfinal <- apply(statsall, 1, mean)

write.csv(statsfinal, file = 'statsall.txt')

(1 - pnorm(1.5, mean = 0, sd = 0.5))
statsfinal <- as.data.frame(statsfinal)
statsfinal[1, 1]
statsfinal[2, 1]


ncol(symbolslist)



nrow(symbolslist)
