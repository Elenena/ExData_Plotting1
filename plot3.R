#Getting data
library(dplyr)
library(lubridate)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","electric_cons.zip")
unzip("electric_cons.zip")

#Preparing data for plotting
electric<-read.table("household_power_consumption.txt", sep=";")
names(electric)<-electric[1,]
electric<-electric[-1,]
electric$Time<-paste(electric$Date,electric$Time)
electric$Date<-dmy(electric$Date)
electric$Time<-strptime(electric$Time, format="%d/%m/%Y %H:%M:%S")
electric<-filter(electric, (Date>=ymd("2007-02-01")&Date<=ymd("2007-02-02")))
electric[,3:9]<-sapply(electric[,3:9],as.numeric)

#plot3
dev.off() #to reset par() skip this line if you don't have any graphic device open
plot(electric$Time,electric$Sub_metering_1, type="l", ylab="Energy sub metering", xlab=character(0))
lines(electric$Time,electric$Sub_metering_2, col="red")
lines(electric$Time,electric$Sub_metering_3, col="blue")
legend("topright", lty=rep(1,3), col=c("black", "red", "blue"), legend=paste(names(electric)[7:9]," "))

dev.copy(png,"plot3.png")
dev.off()