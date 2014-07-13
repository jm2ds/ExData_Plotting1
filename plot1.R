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

#setting additional formating parameters for graph
par(mfrow = c(1,1), 
    mar= c(4, 4, 2, 2),
    cex = .8,
    bg = "transparent")  #examples are transparent but some systems default to white (like mine)

#plotting historgraph
hist(hpcData$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", 
     col = "red",
     breaks=15)

#copying graph to a .png file, default is 480 x 480
dev.copy(png, file = "plot1.png")

#closing device
dev.off()


