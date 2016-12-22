## LOAD NECESSARY PACKAGES
install.packages("dplyr") ## you do not need this if package is already installed 
library(dplyr)
## SET PATH AND FOLDER
path <- getwd() 
if(!file.exists("./data")){dir.create("./data")}
## DOWNLOAD, SAVE AND UNZIP THE FILE; LIST THE NAMES OF THE ZIPPED FILES 
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "OriginalDataSet.zip" 
download.file(url, file.path(path, "data", filename)) 
unzip(file.path(path, "data", filename), exdir = file.path(path, "data")) 
inputpath <- file.path(path, "data")
list.files(inputpath, recursive = TRUE) 
##
## READ THE FILE IN R
dt <- read.table(file.path(path, "data", "household_power_consumption.txt"), header = TRUE, sep = ";", nrow = 80000, as.is = TRUE) 
## Make sure it contains the required two days 
tail(dt)
## Reformat the Date into a date variable 
dt$Date <- as.Date(dt$Date,  format = "%d/%m/%Y")
## Select the rows for the required two days 
dt <- filter(dt, Date == "2007-02-01" | Date == "2007-02-02")
dt[ , 3:9] <- apply(dt[ , 3:9], 2, as.numeric) ## for some reason that I don’t get, the numbers are not imported as numbers (not because of the decimal sign) so here I make them numbers 

## PLOT 1
png(file = "plot1.png", width=480,height=480) 
hist(dt$Global_active_power, col = "red", axes = FALSE, main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
axis(1, c(0,2,4,6))
axis(2, c(0,200,400,600, 800, 1000, 1200))
dev.off()