library(quantmod)
library('stringr')
library('zoo')
library(dplyr)

e <- globalenv()
e.prod <- 0
if (e.prod) setwd('C:\\Users\\bvh8924\\Scripts\\')
wd <- getwd()



e$scriptDir <- paste(wd, "\\", sep = "")
source(paste(e$scriptDir, 'envall.R', sep = ""), echo = FALSE)

if (!exists("foo", mode = "function")) source(paste(e$scriptDir, 'myFUN.R', sep = ''), echo = FALSE)

directory <- e$tradestationOutDir
fname <- "esh20 jan17 5min.txt"
foutvols3 <- "outvols3.txt"
fout3 <- "outkey3.txt"





fname <- paste(e$onedriveDir, fname, sep = "")
foutvols3 <- paste(e$tradestationOutDir, foutvols3, sep = "")
fout3 <- paste(e$tradestationOutDir, fout3, sep = "")

ds <- read.csv(file = fname, header = TRUE)
dsoutvols3 <- read.csv(file = foutvols3, header = TRUE)
dsout3 <- read.csv(file = fout3, header = TRUE)
dsoutvols3 <- read.csv(file = foutvols3, header = TRUE)





params <- Sys.Date()

#params <- as.character(format(params, "%Y-%m-%d %H:%M:%S"))
params <- as.character(format(params, "%Y-%m-%d"))

print(params)
#params <- as.character(format(params, "%m/%d/%Y"))

joined <- dplyr::inner_join(dsoutvols3, dsout3, by = setNames("DateTime", "DateTime"))
nrow(joined)
write.csv(joined, file = paste(e$tradestationOutDir, "joined.txt", sep = ""))
#dshl <- dplyr::filter(joined, High.x == max(High.x) | Low.x == min(Low.x))
dfFilter <- dplyr::filter(joined, grepl(params, DateTime))
dfFilter <- filter(dfFilter, High.x ==max(High.x)|(Low.x ==min(Low.x)) )
#dfFilter <- filter(dfFilter, TRProb >= 80)

nrow(dfFilter)
write.csv(dfFilter, file = paste(e$tradestationOutDir, "MaxMin.txt", sep = ""))
