library('xts')2
library('zoo')
directory = 'C:\\Users\\bvh8924\\OneDrive\\apps\\tradestation\\'
fname = "datetimenew.txt"
fname <- paste(directory, fname, sep = '')
#z <- read.zoo(fname, sep = ",", index = 1,split =1 ,header = TRUE, tz = "", format = "%m/%d/%Y %H:%M:%S")
z <- read.zoo(fname, sep = ",", index = 1,split =1 ,header = TRUE, tz = "",FUn =as.POSIXct.POSIXlt )
xtds <- xts(z)
indexClass(xtds)
xtds[800]



