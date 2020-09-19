
install.packages('dplyr')

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
symbolslist <- read.csv(file = paste(myenv$tradestationOutDir, "testsymbol1.txt", sep = ''))
rcnt <- nrow(symbolslist)
mylist1 <- pull(symbolslist, Ticker)






rcnt







mylist1[1]

for (i in 0:rcnt) {


    element1 <- as.character(mylist1[i])
    print(as.character(element1))



    getSymbols(element1, src = 'yahoo', from = '2018-01-01')
    elename <- paste(element1, ".txt", sep = "")
    print(elename)
    element1ticker <- eval(parse(text = element1))


    write.zoo(element1ticker, file = paste(myenv$tradestationOutDir, elename, sep = ''))
    zobj <- element1ticker
    #processTickers(element1ticker, elementname = element1)
    df1 <-as.data.frame(index(zobj))
    colnames(df1) <- c('Date')
    df2 <- as.data.frame(coredata(zobj))
    #colnames(df2)[2] <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
    

    
    df1 <- cbind(df1, df2)
    #colnames(df1) <- c("ID", "Date", "Open", "High", "Low", "Close", "Volume", "Adjusted")
    write.csv(df1, file = paste(myenv$tradestationOutDir, "df1.txt", sep = ''))
    



    
    
    
    
}

df3 <- read.csv(file = paste(myenv$tradestationOutDir, "df1.txt", sep = ''))
colnames(df3) <- c("ID", "Date", "Open", "High", "Low", "Close", "Volume", "Adjusted")
write.csv(df3, file = paste(myenv$tradestationOutDir, "df1new.txt", sep = ''), row.names = FALSE)
