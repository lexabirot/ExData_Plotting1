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

# plot2
png("./plot2.png")
with(pConsumption, plot(Time,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))
dev.off()
