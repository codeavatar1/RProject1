library(quantmod)
library(dplyr)
rm(list = ls())
rm(list =ls())
if (!exists("foo", mode = "function")) source("envtest.R")
if (!exists("foo1", mode = "function")) source("Script2.R")

argsList <- args


#"C:\\Users\\\\bvh8924\\OneDrive\\Apps\\SPY  March27 60min.txt"

fname <-"C:\\Users\\bvh8924\\OneDrive\\Apps\\SPY  March27 60min.txt"
# set symbol lookup


#setSymbolLookup(SPY = list(src ="csv" , format = "%Y-%m-%d"))
setSymbolLookup(SPY = list(src = fname, format = "%Y/%m/%d"))
df <- read.csv(fname)
colnames(df)

# call getSymbols(.csv) with auto.assign=FALSE
spy <- getSymbols("SPY", auto.assign = FALSE)

temp <- c(0, diff(log(df[, c('Close')])))

df <- cbind(df, temp)
df <- mutate(df, PCHG = temp * 100)
write.csv(df, 'df.txt')

m <- getOHLC(df)
TR <- getTR(m)
TR <- cbind(m, TR)
write.csv(TR, "x1.txt")
