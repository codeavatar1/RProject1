install.packages('zoo')
install.packages('dplyr')
library('dplyr')


directory = 'C:\\Users\\bvh8924\\OneDrive\\apps\\tradestation\\'
fname = "ESH19 March7.txt"
fname = paste(directory, fname, sep = '')

ds <- read.csv(file =fname )
#
    

select(ds, Date, Time, KeyRevDn, KeyRevUp)
filter(ds, KeyRevUp > 0.0 | KeyRevDn > 0.0)
