#yahoo week with no read from disk  final  good version 
install.packages('dplyr')


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
symbolslist <- read.csv(file = paste(myenv$tradestationOutDir, "symbol1.txt", sep = ''))
symbolslist <- arrange(symbolslist, Ticker)
write.csv(symbolslist, file = paste(myenv$tradestationOutDir, "symbol1.txt", sep = ''), row.names = FALSE)
print(rcnt <- nrow(symbolslist))
mylist1 <- symbolslist$Ticker
rcnt
mylist1[0]

for (i in 1:rcnt) {


    element1 <- as.character(mylist1[i])
    element1wk <- paste(element1, "WK", sep = "")
    element1mnth <- paste(element1, "mnth", sep = "")
 element1dup <- paste(element1, "DUP", sep = "")
    if (element1 == "GSPC") getSymbols("^GSPC", src = 'yahoo', from = '2018-01-01')
    else if (element1 == "VIX") getSymbols("^VIX", src = 'yahoo', from = '2018-01-01')
    else if (element1 == "IXIC") getSymbols("^IXIC", src = 'yahoo', from = '2018-01-01')
    else getSymbols(element1, src = 'yahoo', from = '2018-01-01')
    print(as.character(element1))
    
    elename <- paste(element1, ".txt", sep = "")
    element1wkfnme <- paste(element1wk, ".txt", sep = "")
    element1mnthfnme <- paste(element1mnth, ".txt", sep = "")
    print(elename)
    element1ticker <- eval(parse(text = element1))
    write.zoo(element1ticker, file = paste(myenv$tradestationOutDir, elename, sep = ''))
    element1dup <- element1ticker
    
    
    zobj <- element1dup
    df1 <- as.data.frame(coredata(zobj))
    colnames(df1) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
    df1 <- mutate(df1, High = round(as.numeric(High), digits = 3), Low = round(as.numeric(Low), digits = 3))
    df1 <- mutate(df1, Close = round(as.numeric(Close), digits = 3), Open = round(as.numeric(Open), digits = 3))
    
    zobjnu <- xts(order.by =index(zobj), df1)
    dfDate <- as.data.frame(index(zobj))
    element1wk <- to.weekly(zobjnu)
    element1mnth <- to.monthly(zobjnu)
    
    write.zoo(element1wk, file = paste(myenv$tradestationOutDir, element1wkfnme, sep = ''))
    
    write.zoo(element1mnth, file = paste(myenv$tradestationOutDir, element1mnthfnme, sep = ''))
    readfname <- paste(mylist1[i], ".txt", sep = "")
    writefname <- paste(mylist1[i], "TS.txt", sep = "")
    print(readfname)
    

    colnames(dfDate) <- c("Date")
    df3 <- mutate(dfDate, Date = str_replace_all(Date, "-", "/"))
    df3 <- mutate(df3, Date = format(as.Date(Date), "%m/%d/%Y"))
    df3$Time <- as.character(c("16:00"))
    df3 <-cbind(df3, df1)

    write.csv(df3, file = paste(myenv$tradestationOutDir, writefname, sep = ''), row.names = FALSE)


    #processTickers(element1ticker, elementname = element1)
    

    
}


####

