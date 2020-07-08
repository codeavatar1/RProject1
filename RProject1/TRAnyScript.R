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
fname <- "esh20 jan7 5min.txt"
fname <- paste(e$onedriveDir, fname, sep = "")

ds <- read.csv(file = fname, header = TRUE)
mohlc <- getOHLC(ds)
TR <-getTR(mohlc)


#ds2 <- data.frame(matrix(as.numeric(unlist(TR)), nrow = length(TR), byrow = T))





#ds2$TRNu <-as.double(str_replace(ds2$TR,'"',""))
#samp30 <- dplyr::sample_n(ds2, 30)
#mn <- mean(as.numeric(samp30$TR))
#stdeve <-sd(as.numeric(samp30$TR))


#dfFilter <- dplyr::mutate(ds2,TRProb = pnorm(as.numeric(TR), mean = mn ,sd = stdev), round(TRProb*100,3 ))




dsHigh <- dplyr::mutate(ds, TRHigh = ifelse(High - Lag(Close, 1) > 0, High, Lag(Close, 1)))
dsLow <- dsLow <- dplyr::mutate(ds, TRLow = ifelse(Low - Lag(Close, 1) < 0, Low, Lag(Close, 1)))
ds$TR <- dsHigh$TRHigh - dsLow$TRLow
write.csv(ds, file ="TR.txt")




samp30 <- dplyr::sample_n(ds, 30)
mn <- mean(as.numeric(samp30$TR))
stdev <-sd(as.numeric(samp30$TR))
ds <-dfFilter <- dplyr::mutate(ds, TRProb = pnorm(as.numeric(TR), mean = mn, sd = stdev), round(TRProb * 100, 3))
write.csv(ds, file = "TR.txt")
mn
stdev

dsTR <- getTR1(getOHLC(ds))
dsTR$NuTR


