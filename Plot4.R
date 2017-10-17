# Get file

setwd("C:/Users/Andrew/Documents/Coursera/4_Exploratory_Data_Analysis")

unzip("C:/Users/Andrew/Documents/Coursera/4_Exploratory_Data_Analysis/data/exdata_data_household_power_consumption.zip", overwrite = TRUE, exdir = "C:/Users/Andrew/Documents/Coursera/4_Exploratory_Data_Analysis/data")

powerdata <- read.table("C:/Users/Andrew/Documents/Coursera/4_Exploratory_Data_Analysis/data/household_power_consumption.txt", sep = ";")
colnames(powerdata) <- as.character(unlist(powerdata[1,]))
powerdata <- powerdata[-1,]

# Change format of date column
powerdata$Date <- as.Date(powerdata$Date,"%d/%m/%Y")

# Extract the two days of data we are interested in
powerdata <- subset(powerdata, powerdata$Date > "2007/01/31")
powerdata <- subset(powerdata, powerdata$Date < "2007-02-03")

# Plot 4
par(mfrow=c(2,2), mar=c(4,4,1,2))

# a
with( powerdata, plot(DT,Global_active_power,type="l",xlab="",ylab="Global Active Power"))

# b
powerdata$Voltage <- as.numeric(as.character(powerdata$Voltage))
with( powerdata, plot(DT,Voltage,type="l",xlab="datetime",ylab="Voltage"))

# c
with(powerdata,plot(DT,Sub_metering_1, type = "l", col = "grey",xlab="",ylab = "Energy sub metering"))
points(powerdata$DT, powerdata$Sub_metering_2, type = "l", col = "red")
points(powerdata$DT, powerdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", col = c("grey", "red", "blue"), lty = 1)

# d
powerdata$Global_reactive_power <- as.numeric(as.character(powerdata$Global_reactive_power))
with(powerdata,plot(DT,Global_reactive_power, type = "l", xlab="datetime"))

# Save to file
dev.copy(png, file="plot4.png", height=480, width=680)
dev.off()