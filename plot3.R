##Important to Note: This script assumes that the "data.table" package is installed.
##If it is not, 
##uncomment the line below and install it.

#install.packages("data.table")

#loading data.table package
library(data.table)

#reading in data for 1/2/2007 and 2/2/2007 only
hpcData <- fread("household_power_consumption.txt", 
                 nrows=2880,
                 na.strings="?",
                 skip = "1/2/2007", 
                 colClasses= c("character", "character", "numeric", "numeric", "numeric",
                               "numeric", "numeric", "numeric", "numeric"))

#setting column names as header was removed when read in
setnames(hpcData, c(1:9), c("Date", "Time", "Global_active_power", "Global_reactive_power",
                            "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                            "Sub_metering_3"))

#combine date and time
DateTime <- strptime(paste(hpcData$Date, hpcData$Time), "%d/%m/%Y %H:%M")


#opening device to write to a PNG file, default is 480 x 480
png(file = "plot3.png")

#setting additional formating parameters for graph
par(mfrow = c(1,1), 
    mar= c(4, 4, 2, 2),
    cex = .8,
    bg = "transparent")  #examples are transparent but some systems default to white (like mine)

#plotting 
plot(DateTime, hpcData$Sub_metering_1,
     type = "n",
     xlab = "",        
     ylab = "Energy sub metering")

points(DateTime, hpcData$Sub_metering_1, type = "l")
points(DateTime, hpcData$Sub_metering_2, type = "l", col = "red")
points(DateTime, hpcData$Sub_metering_3, type = "l", col = "blue")

legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#closing device
dev.off()