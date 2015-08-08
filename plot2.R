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
png(file="plot2.png", width=480, height=480, bg="transparent")
# plot the chart
plot(epc.data.set$DateTime, epc.data.set$Global_active_power, type = "l", 
     xlab = NA, ylab="Global Active Power (kilowatts)")
# and close the file
dev.off()