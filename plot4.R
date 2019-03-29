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
png("plot4.png")
par(mfrow = c(2,2))

with(dat1, plot(DateTime, Global_active_power, type = "l", 
                xlab = "", ylab = "Global Active Power"))
with(dat1, plot(DateTime, Voltage, type = "l", 
                xlab = "datetime", ylab = "Voltage"))

with(dat1, plot(DateTime, Sub_metering_1, type = "l", ylim = c(0, 40),
                xlab = "", ylab = "Energy sub metering"))
lines(dat1$DateTime, dat1$Sub_metering_2, col = "red")
lines(dat1$DateTime, dat1$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), cex = 0.7, lwd = 0.7)
with(dat1, plot(DateTime, Global_reactive_power, type = "l", 
                xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()



