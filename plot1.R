library(data.table)
library(dplyr)
library(lubridate)

#Downloading and unzipping the dataset
if(!file.exists("./data")){
        dir.create("./data")
}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data/power.zip")){
        download.file(fileurl,"./data/power.zip")
        unzip("./data/power.zip",exdir = "./data")
}

#Reading the data set into dt
dt <- tbl_df(fread("./data/household_power_consumption.txt",header = TRUE,na.strings = "?"))

#Converting the Date variable to Date class and Subsetting according to the given dates
dt <- dt %>% mutate(Date = dmy(Date)) %>%
        filter(Date == ymd("2007-02-01")|Date == ymd("2007-02-02"))

#Removing NAs
dt <- dt[complete.cases(dt),]

#Creating DateTime variable 
dt <- dt %>% mutate(dateTime = paste(Date,Time),dateTime = as.POSIXct(dateTime)) 

#PLOTTING plot1

png(filename = "plot1.png", height = 480,width = 480)
with(dt,hist(Global_active_power,
             col = "red", 
             xlab = "Global Active Power (kilowatts)",
             main = "Global Active Power"))
dev.off()
