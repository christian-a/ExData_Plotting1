# check if file exists otherwise download and/or extract file
if (!file.exists("./data/household_power_consumption.txt")) {
    if (!file.exists("./data")) {
        dir.create("data")
    }
    
    # check if zip exists otherwise download
    if (!file.exists("./data/household_power_consumption.zip")) {
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url, "./data/household_power_consumption.zip", method = "curl")
    }
    
    # unzip the file
    unzip("./data/household_power_consumption.zip", exdir = "data")
}

# read in the data and subset only the 1st and 2nd February 2007
epc.data.set <- read.csv("./data/household_power_consumption.txt", header = T, 
                         sep=";", na.strings = "?")
epc.data.set <- subset(epc.data.set, Date == "1/2/2007" | Date == "2/2/2007")

# converts character representation of date and time to objects 
# of classes "POSIXlt" and "POSIXct"
epc.data.set$DateTime <- strptime(paste(epc.data.set$Date, epc.data.set$Time), 
                                  format = "%d/%m/%Y %H:%M:%S")

# create a new png file with transparent background for plotting in
png(file="plot4.png", width=480, height=480, bg="transparent")


mfrow.bak <- par("mfrow")
# chart with 2 x 2
par(mfrow = c(2, 2))

# chart 1: Global Active Power
with(epc.data.set, plot(DateTime, Global_active_power, type = "l", xlab = NA, 
                        ylab="Global Active Power"))

# chart 2: voltage
with(epc.data.set, plot(DateTime, Voltage, type = "l", xlab = "datetime", 
                        ylab="Voltage"))

# chart 3: Energy sub metering
plot(epc.data.set$DateTime, epc.data.set$Sub_metering_1, type = "l", xlab = NA, 
     ylab = "Energy sub metering")
points(epc.data.set$DateTime, epc.data.set$Sub_metering_2, type = "l", col="red")
points(epc.data.set$DateTime, epc.data.set$Sub_metering_3, type = "l", col="blue")

# legend
legend("topright", # places a legend at the appropriate place 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), # puts text in the legend
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5), bty = "n", col=c("black", "red", "blue"))

# chart 4: Global_reactive_power
with(epc.data.set, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))

# and close the file
dev.off()

par(mfrow = mfrow.bak)