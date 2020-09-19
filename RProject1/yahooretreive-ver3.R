
library(quantmod)
library('stringr')
library('zoo')
library(dplyr)

e <- globalenv()
e.prod <- 0
if (e.prod) setwd('C:\\Users\\bvh8924\\Scripts\\')
wd <- getwd()
myenv <- e
directory <- myenv$workDir


e$scriptDir <- paste(wd, "\\", sep = "")
source(paste(e$scriptDir, 'envall.R', sep = ""), echo = FALSE)

if (!exists("foo", mode = "function")) source(paste(e$prodDir, 'myFUN.R', sep = ''), echo = FALSE)
symbolslist <- read.csv(file = paste(myenv$tradestationOutDir, "symbol1.txt", sep = ''))
rcnt <- nrow(symbolslist)
#mylist1 <- pull(symbolslist, Ticker)
rcnt
tickerlist <- symbolslist$Ticker



for (i in 1:rcnt) { 
readfname <- paste(tickerlist[i], ".txt", sep = "")
writefname <- paste(tickerlist[i], "TS.txt", sep = "")
print(readfname)
print(writefname)
    readfname <- paste(myenv$tradestationOutDir, readfname, sep = '')
    print(readfname)
    #df3 <- read.csv(file = readfname, sep ="\t")

    df3 <- read.csv(file = readfname, sep = "\t")
    print(nrow(df3))

                    
}



