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

#Create and save the plot as a png file
#Histogram: Time and Global_active_power

png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(epc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()



