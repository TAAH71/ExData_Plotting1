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

# Plot 3
powerdata$Sub_metering_1 <- as.numeric(as.character(powerdata$Sub_metering_1))
powerdata$Sub_metering_2 <- as.numeric(as.character(powerdata$Sub_metering_2))
powerdata$Sub_metering_3 <- as.numeric(as.character(powerdata$Sub_metering_3))
with(powerdata,plot(DT,Sub_metering_1, type = "l", col = "grey",xlab="",ylab = "Energy sub metering"))
points(powerdata$DT, powerdata$Sub_metering_2, type = "l", col = "red")
points(powerdata$DT, powerdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("grey", "red", "blue"), lty = 1)

# Save to file
dev.copy(png, file="plot3.png", height=480, width=680)
dev.off()
