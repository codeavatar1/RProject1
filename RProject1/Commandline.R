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







params <- commandArgs(trailingOnly = TRUE)
params <- "NKLA"






tickers <- c('SDS')
#SP500V <-getSymbols("^SP500V", src = 'yahoo', from = '2018-01-01')
getSymbols(params, src = 'yahoo', from = '2018-01-01')

params <- eval(parse(text = params))
write.zoo(params, file ="ts1.txt")

#write.zoo(SP500V, file = "ts1.txt")