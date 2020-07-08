library('xts')
library('zoo')
ds <- read.csv(file = fname)
row.names(ds) <-NULL
write.csv(file = "datetime2.txt", ds[,2:6])
