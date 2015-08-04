# read in the data and subset only the 1st and 2nd February 2007
epc.data.set <- read.csv("./data/household_power_consumption.txt", header = T, 
                         sep=";", na.strings = "?")
epc.data.set <- subset(epc.data.set, Date == "1/2/2007" | Date == "2/2/2007")

# create a new png file with transparent background for plotting in
png(file="plot1.png", width=480, height=480, bg="transparent")
# plot the histogram
hist(epc.data.set$Global_active_power, xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", col="#FF2500")
# and close the file
dev.off()