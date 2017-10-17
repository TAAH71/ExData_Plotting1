# Download file

setwd("C:/Users/Andrew/Documents/Coursera/DataExp")
downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "C:/Users/Andrew/Documents/Coursera/DataExp/household_power_consumption.zip"
householdFile <- "C:/Users/Andrew/Documents/Coursera/DataExp/household_power_consumption.txt"

if (!file.exists(householdFile)) {
  download.file(downloadURL, downloadFile, method = "curl")
  unzip(downloadFile, overwrite = TRUE, exdir = "C:/Users/Andrew/Documents/Coursera/DataExp")
}

powerdata <- read.table("household_power_consumption.txt", sep = ";")
colnames(powerdata) <- as.character(unlist(powerdata[1,]))
powerdata <- powerdata[-1,]

# Change format of date column
powerdata$Date <- as.Date(powerdata$Date,"%d/%m/%Y")

# Extract the two days of data we are interested in
powerdata <- subset(powerdata, powerdata$Date > "2007/01/31")
powerdata <- subset(powerdata, powerdata$Date < "2007-02-03")

# Plot 1
powerdata$Global_active_power <- as.numeric(as.character(powerdata$Global_active_power))
hist(powerdata$Global_active_power, col = "red",main = "Global Active Power",xlab = "Global Active Power (killowatts)")

# Plot 2
powerdata$DT <- paste(powerdata$Date, powerdata$Time, sep = " ")
powerdata$DT <-as.POSIXct(powerdata$DT)
with(powerdata,plot(DT,Global_active_power, type="l",ylab = "Global Active Power (Killowatts)", xlab = ""))

# Plot 3
powerdata$Sub_metering_1 <- as.numeric(as.character(powerdata$Sub_metering_1))
powerdata$Sub_metering_2 <- as.numeric(as.character(powerdata$Sub_metering_2))
powerdata$Sub_metering_3 <- as.numeric(as.character(powerdata$Sub_metering_3))
with(powerdata,plot(DT,Sub_metering_1, type = "l", col = "grey",ylab = "Energy sub metering"))
points(powerdata$DT, powerdata$Sub_metering_2, type = "l", col = "red")
points(powerdata$DT, powerdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("grey", "red", "blue"), lty = 1)

# Plot 4
par(mfrow=c(2,2))

# a
with( powerdata, plot(DT,Global_active_power,type="l",xlab="",ylab="Global Active Power"))

# b
powerdata$Voltage <- as.numeric(as.character(powerdata$Voltage))
with( powerdata, plot(DT,Voltage,type="l",xlab="datetime",ylab="Voltage"))

# c
with(powerdata,plot(DT,Sub_metering_1, type = "l", col = "grey",ylab = "Energy sub metering"))
points(powerdata$DT, powerdata$Sub_metering_2, type = "l", col = "red")
points(powerdata$DT, powerdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", col = c("grey", "red", "blue"), lty = 1)

# d
powerdata$Global_reactive_power <- as.numeric(as.character(powerdata$Global_reactive_power))
with(powerdata,plot(DT,Global_reactive_power, type = "l", xlab="datetime"))

## Saving to file
#dev.copy(png, file="plot3.png", height=480, width=480)
#dev.off()