library('zoo')
library('xts')
#xts1 <- xts(a = 1:10, order.by = Sys.Date() - 1:10)
directory = 'C:\\Users\\bvh8924\\OneDrive\\apps\\tradestation\\'
fname = "datetimenew.txt"
fname = paste(directory, fname, sep = '')
ds <- read.csv(file = fname)

xds <- xts(ds, order.by = as.POSIXlt(ds$DateTime,tz ="", format = "%m/%d/%Y %H:%M"))
#xds <- xts(ds, order.by = as.Date(ds$DateTime, format = "%m/%d/%y %H:%M"))
 indexClass(xds)
indexTZ(xds)
periodicity(xds)

start(xds)
end(xds)
str(xds)


write.csv(xds, file = 'datetime.txt')
indexClass(xds)
##


#nhours(xds)
#to.period(xds, k = 1,indexAt = "startof", period = 'minutes')
#to.period(x = xds, k = 2)
