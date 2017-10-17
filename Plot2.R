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

# Plot 2
powerdata$DT <- paste(powerdata$Date, powerdata$Time, sep = " ")
powerdata$DT <-as.POSIXct(powerdata$DT)
with(powerdata,plot(DT,Global_active_power, type="l",ylab = "Global Active Power (Killowatts)", xlab = ""))

# Save to file
dev.copy(png, file="plot2.png", height=480, width=680)
dev.off()
