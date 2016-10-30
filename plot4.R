#Download the data

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./EPC")){
	dir.create("./EPC")
	download.file(url, destfile = "./EPC/epc.zip")
	
	#Unzip the file
	unzip(zipfile = "./EPC/epc.zip", exdir = "./EPC")
	}

#Read all the data and create data frame "epc" with 01-02 & 02-02 of 2007 data.

epc <- read.table("./EPC/household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE, skip = 66636, nrows = 2880)
epc_names <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
names(epc) <- epc_names

#Format the dates and create new data frame called "epc2"

Full_Date <- paste(epc$Date, epc$Time)
epc2 <- cbind(epc, Full_Date)
epc2$Full_Date = strptime(epc2$Full_Date, format = "%d/%m/%Y %H:%M:%S")

#Create and save the required plot as a png file
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))

#plot1: Time and Global_active_power

with(epc2, {
	plot(Full_Date, Global_active_power, ylab = "Global Active Power", xlab = "", type = "n")
	lines(Full_Date, Global_active_power, col = "black")
	})

#plot2: Time and Voltage

with(epc2, {
	plot(Full_Date, Voltage, ylab = "Voltage", xlab = "datetime", type = "n")
	lines(Full_Date, Voltage, col = "black")
	})

#plot3: Time and  Sub_metering (1, 2 & 3)

with(epc2, {
	plot(Full_Date, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n")
	lines(Full_Date, Sub_metering_1, col = "black")
	lines(Full_Date, Sub_metering_2, col = "red")
	lines(Full_Date, Sub_metering_3, col = "blue")
	legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
	})

#plot4: Time and Global_reactive_power

with(epc2, {
	plot(Full_Date, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "n")
	lines(Full_Date, Global_reactive_power, col = "black")
	})

dev.off()