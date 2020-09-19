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


symbolslist <- read.csv(file = paste(myenv$tradestationOutDir, "symbol1.csv", sep = ''))

rcnt <- nrow(symbolslist)
rcnt



mylist <- symbolslist$Ticker


mylist1 <- pull(symbolslist, Ticker)
mylist1[1]

for (i in 0:rcnt) { 
    
    
    element1 <- as.character(mylist1[i])
    print(as.character(element1))
    
    
    getSymbols(element1, src = 'yahoo', from = '2018-01-01')
    
    elename <- paste(element1, ".csv", sep = "")
    print(elename)
    element1ticker <- eval(parse(text = element1))
    write.zoo(element1ticker, file = paste(myenv$tradestationOutDir, elename, sep = ''))
}






GSPC <- as.xts(SPY)

colnames(GSPC) <- c( "Open", "High","Low","Close", "Volume", "Adjusted")
GSPC$XTSDate <- index(GSPC)
df1 <- as.data.frame(index(GSPC))
colnames(df1) <- c('Date')
df1$Date <-as.character(format(df1$Date, "%m/%d/%Y"))
df1$Time <- as.character(c("16:00"))



df2 <- as.data.frame(coredata(GSPC))
df1 <-c(df1, df2)
write.zoo(GSPC, file = paste(myenv$tradestationOutDir, "GSPC.txt", sep = ''))
write.csv(df1, file = paste(myenv$tradestationOutDir, "XTSGSPC.txt", sep = ''))

