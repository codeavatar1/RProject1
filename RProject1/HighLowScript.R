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

foutvols3 <- "outvols3.txt"
fout3 <- "outkey3.txt"
#Do get teh trigger file
df1 <- read.csv(myenv$trigFile)
processFile <- df1[1, 1]

myenv$processFile <- paste(myenv$processDir, processFile, sep = '\\')
print(myenv$processFile)


foutvols3 <- paste(e$tradestationOutDir, foutvols3, sep = "")
fout3 <- paste(e$tradestationOutDir, fout3, sep = "")


dsoutvols3 <- read.csv(file = foutvols3, header = TRUE)
dsout3 <- read.csv(file = fout3, header = TRUE)
#dfFilter <- dplyr::filter(ds, grepl("01/08/2020" , Date))
#params <- eval(parse(text =Sys.Date())
params <- Sys.Date() 
params <- as.character(format(params, "%Y-%m-%d"))
#dfFilter <- dplyr::filter(ds, grepl(as.Date(Sys.Date()), DateTime))
#dfFilter <- dplyr::filter(ds, grepl(params, DateTime))
#nrow(dfFilter)
#dfFilter <- dplyr::filter(dfFilter, High == max(High) | Low == min(Low))
#write.csv(dfFilter, paste(directory,"MaxMIn.txt" , sep = '\\'))


params


#joined <- dplyr::left_join(dsoutvols3, dsout3, by =setNames(Open, Open))
joined <- dplyr::inner_join(dsoutvols3, dsout3, by = setNames("DateTime", "DateTime"))
#Date <-  as.character(format(joined$DateTime, "%Y-%m-%d"))
joined <- dplyr::mutate(joined, "Date" = as.Date(DateTime, "%Y-%m-%d"))

#Date <- format(joined$DateTime, "%Y-%m-%d")
nrow(joined)
print(params)

write.csv(joined, file = paste(e$tradestationOutDir, "joined.txt", sep = ""))
dfFilter <- dplyr::filter(joined, grepl(params, Date))
dfFilter <- dplyr::filter(dfFilter, High.x == max(High.x) | Low.x == min(Low.x))
write.csv(dfFilter, paste(directory,"MaxMIn.txt" , sep = '\\'))

print(params)