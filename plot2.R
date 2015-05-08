#1. download the file and read into table
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile="./myfile.zip")
unzip("myfile.zip")
mydf <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors=FALSE)

#2. filter the date from 2007-02-01 and 2007-02-02
library(dplyr)
mydf <- mutate(mydf, Date_format = as.Date(Date, "%d/%m/%Y"))
mydf <- filter(mydf, Date_format >= as.Date("2007-02-01"), Date_format <= as.Date("2007-02-02"))

#3. plot 
x <- strptime(paste(mydf$Date, mydf$Time, sep="/"), format = "%d/%m/%Y/%H:%M:%S")
y <- mydf$Global_active_power
plot(x, y, type="l", ylab = "Global Active Power(kilowatts)", xlab="")

#4. convert to png
dev.copy(png, file = "plot2.png")
dev.off()