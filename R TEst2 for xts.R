library('zoo')
library('xts')
#xts1 <- xts(a = 1:10, order.by = Sys.Date() - 1:10)
directory = 'C:\\Users\\bvh8924\\OneDrive\\apps\\tradestation\\'
fname = "datetime.txt"
fname = paste(directory, fname, sep = '')

#fINdex function 
fIndex <- function(x) {
    #v1 <- as.vector(x)
    v1 <- as.data.frame(x)
    vlen = length(v1)
    vret <- vector(vlen)
    for (i in 1:vlen) {
        vret[i] <- as.POSIXlt(v1[i], format = "%m/%d/%y %H:%M")
    }

    return(vret)
}

ds = read.csv(file = fname)
colnames(ds)
mat1 <- ds[, c('Open', 'High', 'Low', 'Close')]
mat1 <- as.matrix(mat1)
nrow(mat1)
xds <- xts()

#xds <- xts(mat1, rowIDs)


indexfordate <- as.POSIXlt(ds$DateTime, format = "%m/%d/%y %H:%M")
indexfordate <- as.vector(indexfordate)

#xtds <- as.xts(mat1, indexfordate)

#xtds <- xts(ds, order.by = as.POSIXlt(ds$DateTime, format = "%m/%d/%y %H:%M"))
#xtds <- xts(ds, order.by = as.POSIXlt(as.character(ds$DateTime), format = "%m/%d/%y %H:%M"))
xtds <- xts(ds, order.by = as.Date(as.character(ds$DateTime), format = "%m/%d/%y %H:%M"))
xds <- xtds


indexClass(xds)
str(xds)
#periodicity(xds)
days <- c('03/08/2019 15:00')
xtds[as.Date(days)]
coredata(days)
#as.numeric(xds)
write.csv(xtds, file = 'tseriesdata.txt')
#first(xtds)
#last(xtds)
#xtds["2019"]
#.indexhour(xtds)
#nmonths(xtds)
#ndays(xtds)




#.index(xtds)
indexClass(xtds)
indexTZ(xtds)
indexFormat(xtds)
write.csv(index(xtds), file = 'indexonly.txt')
to.minutes30(xtds, 'OHLC')
