library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","Data.zip")
unzip(paste(getwd(),"/Data.zip",sep=''),exdir=paste(getwd(),"/Data",sep=''))
#Reading the dataset
pConsumption<-read.csv("./Data/household_power_consumption.txt",nrows=100,na.strings = "?",sep=';')#First Read a sample
classes<-sapply(pConsumption,class) #Extract coloumns types
pConsumption <- read.csv("Data/household_power_consumption.txt", sep=";",colClasses = classes, na.strings = "?")#Read the whole Dataset
pConsumption$Time<-as.POSIXct(paste(pConsumption$Date,pConsumption$Time),format="%d/%m/%Y %H:%M:%S")#Concatenate Date&Time variables to convert the Time variable as Date/Time
pConsumption$Date<-as.Date(pConsumption$Date,format="%d/%m/%Y")
pConsumption<-filter(pConsumption,Date=="2007-02-01" | Date=="2007-02-02")

# plot4
png("./plot4.png")
par(mfrow=c(2,2))
with(pConsumption, plot(Time,Global_active_power,type="l",ylab="Global Active Power",xlab=""))
with(pConsumption, plot(Time,Voltage,type="l",ylab="Voltage",xlab="datetime"))
with(pConsumption,{
        plot(Time,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
        lines(Time,Sub_metering_2,type="l",col="red")
        lines(Time,Sub_metering_3,type="l",col="blue")
})
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,xjust=1)
with(pConsumption, plot(Time,Global_reactive_power,type="l",xlab="datetime"))
dev.off()