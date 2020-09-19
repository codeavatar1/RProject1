#install.packages('dplyr')


library(quantmod)
library('stringr')
library('zoo')
library(dplyr)

e <- globalenv()
e.prod <- 1
if (e.prod) setwd('C:\\Users\\bvh8924\\Scripts\\')
wd <- getwd()
myenv <- e
directory <- myenv$workDir


e$scriptDir <- paste(wd, "\\", sep = "")
source(paste(e$scriptDir, 'envall.R', sep = ""), echo = FALSE)

if (!exists("foo", mode = "function")) source(paste(e$prodDir, 'myFUN.R', sep = ''), echo = FALSE)
symbolslist <- read.csv(file = paste(myenv$tradestationOutDir, "testsymbol1.txt", sep = ''))
rcnt <- nrow(symbolslist)
mylist1 <- symbolslist$Ticker
rcnt
mylist1[0]

for (i in 1:rcnt) {


    element1 <- as.character(mylist1[i])
    if (element1 == "GSPC") getSymbols("^GSPC", src = 'yahoo', from = '2018-01-01')
    else if (element1 == "VIX") getSymbols("^VIX", src = 'yahoo', from = '2018-01-01')
    else if (element1 == "IXIC") getSymbols("^IXIC", src = 'yahoo', from = '2018-01-01')
    else getSymbols(element1, src = 'yahoo', from = '2018-01-01')
    print(as.character(element1))
    #getSymbols(element1, src = 'yahoo', from = '2018-01-01')
    elename <- paste(element1, ".txt", sep = "")
    print(elename)
    element1ticker <- eval(parse(text = element1))


    write.zoo(element1ticker, file = paste(myenv$tradestationOutDir, elename, sep = ''))
    zobj <- element1ticker
    zobjnew <- xts(zobj)

    #processTickers(element1ticker, elementname = element1)
    #colnames(zobjnew) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")

    #colnames(zobjnew) <- c("ID", "Date", "Open", "High", "Low", "Close", "Volume", "Adjusted")
}


#####
for (i in 1:rcnt) {


    readfname <- paste(mylist1[i], ".txt", sep = "")
    writefname <- paste(mylist1[i], "TS.txt", sep = "")
    print(readfname)
    df3 <- read.csv(file = paste(myenv$tradestationOutDir, readfname, sep = ''), sep = " ")

    colnames(df3) <- c("Date", "Open", "High", "Low", "Close", "Volume", "Adjusted")
    df3 <- mutate(df3, Date = str_replace_all(Date, "-", "/"))
    df3 <- mutate(df3, Date = format(as.Date(Date), "%m/%d/%Y"))
    df3$Time <- as.character(c("16:00"))
    df3 <- mutate(df3, High = round(as.numeric(High), digits = 3), Low = round(as.numeric(Low), digits = 3))
    df3 <- mutate(df3, Close = round(as.numeric(Close), digits = 3), Open = round(as.numeric(Open), digits = 3))

    write.csv(df3, file = paste(myenv$tradestationOutDir, writefname, sep = ''), row.names = FALSE)


}

ROKUW <- to.weekly(ROKU)
sma <- SMA(Cl(ROKUW), n = 20)
#RSI(ROKU, n = 14, maTyep = 1)
write.zoo(ROKUW, file = paste(myenv$tradestationOutDir,"rokuw.txt" , sep = ''), row.names = FALSE)