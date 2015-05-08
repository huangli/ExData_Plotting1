
#1. download the file and read into table
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile="./myfile.zip")
unzip("myfile.zip")
mydf <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors=FALSE)

#2. filter the date from 2007-02-01 and 2007-02-02
library(dplyr)
mydf <- mutate(mydf, Date_format = as.Date(Date, "%d/%m/%Y"))
mydf <- filter(mydf, Date_format >= as.Date("2007-02-01"), Date_format <= as.Date("2007-02-02"))

#3. plot and create png
png("plot4.png")
par(mfrow=c(2,2))
x <- strptime(paste(mydf$Date, mydf$Time, sep="/"), format = "%d/%m/%Y/%H:%M:%S")

#3.1 first chart topleft
y <- mydf$Global_active_power
plot(x, y, type="l", ylab = "Global Active Power(kilowatts)", xlab="")

#3.2 second chat topright
y <- mydf$Voltage
plot(x, y, type="l", ylab = "Voltage", xlab="datetime")

#3.3 third chart bottom left
y <- mydf$Sub_metering_1
plot(x, y, type="l", ylab = "Energy sub metering", xlab="")
lines(x, mydf$Sub_metering_2, type='l', col='red')
lines(x, mydf$Sub_metering_3, type='l', col='blue')
legend("topright", 
       lty=c(1,1,1),
       lwd=c(1,1,1), 
       col=c("black","red","blue"), 
       legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#3.4 fourth chart bottom right
y <- mydf$Global_reactive_power
plot(x, y, type="l", ylab = "Global_reactive_power", xlab="datetime")

#4. create png
dev.off()
