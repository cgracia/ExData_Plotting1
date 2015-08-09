## This script reads the electric consumption data and plots the Global Active
## Power vs the date.

# Load the data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                   na.strings = "?")

# Combine date and time in one column.
Combined_Time <-
        strptime(paste(data$Date,data$Time, sep = " "),"%d/%m/%Y %H:%M:%S")
data <- cbind(Combined_Time, data)

# Drop the date and time columns
drops <- c("Date","Time")
data <- data[,!(names(data) %in% drops)]

# Select the data from the dates 2007-02-01 and 2007-02-02
date1 <- as.POSIXct("2007-02-01 00:00:00")
date2 <- as.POSIXct("2007-02-02 23:59:59")
subdata <- subset(data, Combined_Time >= date1 & Combined_Time < date2)

## The required subset is ready, we can now proceed to plot.
png('plot2.png')
plot(subdata$Combined_Time, subdata$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
