# R Script to read in data from UC Irvine Machine Learning Repo and make an
# exploratory histogram plot of Global Active Power vs Frequency for 2 days
# in 2007-02-01 and 2007-02-02

# Assume file is in the current working directory
fileName <- "household_power_consumption.txt"
dat <- read.table(fileName, header=TRUE, sep=";", na.strings="?", colClasses=c(rep("character",2), rep("numeric",7)))

# Extract Dates and Times and create DateTime type
dateTimeFormat <- "%Y-%m-%d %H:%M:%S"
dates <- as.Date(dat$Date, format="%d/%m/%Y")
dat$DateTime <- strptime(paste(dates,dat$Time), dateTimeFormat)

# Subset dat to get only consumption between 2007-02-01 and 2007-02-02
dat <- subset(dat, DateTime >= as.POSIXlt('2007-02-01 00:00:00') & DateTime < as.POSIXlt('2007-02-03 00:00:00'))

png(file="plot4.png", width=480, height=480, units="px") # Open png device
par(mfrow=c(2,2))
with(dat, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
with(dat, plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))
with(dat, plot(DateTime,Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
# Draw 3 plots
lines(dat$DateTime,dat$Sub_metering_1, col="black")
lines(dat$DateTime,dat$Sub_metering_2, type="l", col="red")
lines(dat$DateTime,dat$Sub_metering_3, type="l", col="blue")
# Create Legend
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1,box.lwd = 0,box.col = "white",bg = "white")

with(dat, plot(DateTime,Global_reactive_power, type="l", xlab="datetime"))
dev.off() # Close Device
