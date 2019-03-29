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

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
dat1 <- data %>%
    filter(Date >= as.Date("2007-02-01") & date <= as.Date("2007-02-02"))
# plot histogram for Global_Active_Power
png("plot1.png", width = 480, width = 480)
hist(dat1$Global_active_power, col = 'red',
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

