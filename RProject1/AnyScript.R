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

if (!exists("foo", mode = "function")) source(paste(e$scriptDir, 'myFUN.R', sep = ''), echo = FALSE)
#fname <- "tradestation\\outvols3.txt"
fname <- "esh20 jan6 5min.txt"
fname <- paste(e$onedriveDir, fname, sep = "")

ds <- read.csv(file = fname, header = TRUE)
mohlc <- getOHLC(ds)
TR <- getTR(mohlc)
print(TR)
TR
ds2 <- data.frame(matrix(unlist(TR), nrow = length(TR), byrow = T))
nrow(ds2)
colnames(ds2)



#ds2$TRNu <-as.double(str_replace(ds2$TR,'"',""))
samp30 <- dplyr::sample_n(ds2, 30)
mn <- mean(as.numeric(samp30$TR))
stdeve <- sd(as.numeric(samp30$TR))

mn
#dfFilter <- dplyr::mutate(ds2,TRProb = pnorm(as.numeric(TR), mean = mn ,sd = stdev), round(TRProb*100,3 ))
ds2


/ *
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

if (!exists("foo", mode = "function")) source(paste(e$scriptDir, 'myFUN.R', sep = ''), echo = FALSE)
#fname <- "tradestation\\outvols3.txt"
fname <- "esh20 jan3 5min.txt"
fname <- paste(e$onedriveDir, fname, sep = "")

ds <- read.csv(file = fname, header = TRUE)
mohlc <- getOHLC(ds)
tr <- getTR(mohlc)
print(tr)
tr

nrow(ds)

#ds$TRNu <-as.double(str_replace(ds$TRs,'"',""))

ds$DateTime <- ds[, c('X')]
mdata <- as.matrix(ds[, c('Open', 'High', 'Low', 'Close')])

#rowIndex <- as.POSIXlt(ds$DateTime, tz = "", format = "%m/%d/%Y %H:%M")
rowIndex <- as.POSIXlt(ds$DateTime, tz = "", format = "%Y-%m-%d %H:%M:%S")
ts1 <- xts(mdata, order.by = rowIndex)
ts1hlc <- quantmod::HLC(ts1)
ts1hlc$Open <- ts1hlc$Close

dataPeriod <- as.character(periodicity(ts1))
dataPeriod1 <- as.vector(periodicity(ts1))
print(dataPeriod1)

colnames(ds)

dfFilter <- dplyr::filter(ds, grepl(Sys.Date() - 2, DateTime))


#samp30 <- dplyr::sample_n(dfFilter, 30)
#samp30 <- dplyr::mutate(samp30, TRNu = as.numeric(TRNu))
#mean30 <- mean(samp30$TRNu)
#sd30 <- sd(samp30$TRNu)
#dfFilter <- dplyr::mutate(dfFilter,TRProb = pnorm(as.numeric(TRNu), mean = mean30, sd = sd30), round(TRProb*100,3 ))
#write.csv(dfFilter, file = 'dffilter.txt')
#write.csv(samp30, file = 'samp30.txt')

dsmax <- dplyr::filter(dfFilter, TRNu == max(#TRNu ))
#dsmax$TRProb
#dsmax$DateTime

* /