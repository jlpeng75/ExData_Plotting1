setwd("C:/Users/jpeng11/coursera/Exploratory Data Analysis/ExData_Plotting1")
library(dplyr)
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "Household_Power_Consumption.zip", mode = "wb")
download.time <- Sys.time()

master <- as.character(unzip("Household_Power_Consumption.zip", list = T)$Name)
data <- read.table(unz("Household_Power_Consumption.zip", 
                       "household_power_consumption.txt"),
                   header = T, sep = ";", na.strings = "?", stringsAsFactors = F)

str(data)
data$DateTime <- as.POSIXct(strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S"))
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

dat1 <- data %>%
    filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02")) %>%
    mutate(DayOfWeek = weekdays(Date, abbreviate = T ))
# plot histogram for Global_Active_Power
png("plot2.png")
with(dat1, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()



