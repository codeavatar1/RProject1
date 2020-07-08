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

if (!exists("foo", mode = "function")) source(paste(e$prodDir, 'myFUN.R', sep = ''), echo = FALSE)
params <- commandArgs(trailingOnly = TRUE)
print(params)

fname <- "esz19 dec19 720min.txt"

fname <- paste(e$onedriveDir, fname, sep = "")

ds <- read.csv(file = fname, header = TRUE)

nrow(ds)
ds$DateTime <- paste(ds$Date, ds$Time, sep = ' ')
mdata <- as.matrix(ds[, c('Open', 'High', 'Low', 'Close')])
rowIndex <- as.POSIXlt(ds$DateTime, tz = "", format = "%m/%d/%Y %H:%M")
ts1 <- xts(mdata, order.by = rowIndex)
dataPeriod <- as.character(periodicity(ts1))
dataPeriod1 <- as.vector(periodicity(ts1))
print(dataPeriod1)
#dfFilter <- dplyr::filter(ds, grepl('2019-12-20', DateTime) & ProbRet < 20)
#dfFilter <- dplyr::filter(ds, grepl('05:00', DateTime))
dfFilter <- dplyr::filter(ds, grepl('16:00', DateTime))


print(rowcnt <- nrow(dfFilter))


s10 <-dfFilter

sd1 <- runSD(diff(log(s10[, c('Close')])) * 100,20)
sd2 <- sd1[25]
(sd2 ^ 2) * 252
sd1 <- runSD(dailyReturn(to.daily(ts1)), 20)
sd25 <- sd1[nrow(sd1)]

ADX(HLC(ts1), n = 2)
ts2 <- as.data.frame(cbind(diff(ts1[, c('High')]),diff( ts1[, c('Low')])))

ts2 <- mutate(ts2, DIp = ifelse(High > 0, High, 0), DIn = ifelse(Low < 0, Low, 0))

write.csv(ts2, file = 'dffilter.txt')
          arrange(dfFilter,DateTime, Low )
          

sd25
(sd25 ** 2) * 252

Sys.Date()