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
DT <- as.data.frame(ds[, c('DateTime')])
vDT <-as.vector(DT[,1])
length(vDT)
rowIDs <- fIndex(vDT)

#rowID <- as.POSIXlt(DateTime[,1], format = "%m/%d/%y %H:%M")


xds <- xts(mat1, rowIDs)
indexClass(xds)
str(xds)
nmonths(xtds)
ndays(xtds)


