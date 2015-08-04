# read in the data and subset only the 1st and 2nd February 2007
epc.data.set <- read.csv("./data/household_power_consumption.txt", header = T, 
                         sep=";", na.strings = "?")
epc.data.set <- subset(epc.data.set, Date == "1/2/2007" | Date == "2/2/2007")

epc.data.set$DateTime <- strptime(paste(epc.data.set$Date, epc.data.set$Time), 
                                  format = "%d/%m/%Y %H:%M:%S")

# create a new png file with transparent background for plotting in
png(file="plot2.png", width=480, height=480, bg="transparent")
# plot the chart
plot(epc.data.set$DateTime, epc.data.set$Global_active_power, type = "l", 
     xlab = NA, ylab="Global Active Power (kilowatts)")
# and close the file
dev.off()