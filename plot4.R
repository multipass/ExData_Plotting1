#download and extract data from archive
archive.remote <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
archive.local <- "explopc.zip"
download.file(archive.remote, archive.local, method="curl")
f<-unzip(archive.local)

#Extract data from 1-Feb-2007 and 2-Feb-2007
library(sqldf)
df<-read.csv.sql(f, "select * from file where Date in ('1/2/2007', '2/2/2007')", sep=";")

#format time and date
df$Time<-strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df$Date<-as.Date(df$Date, "%d/%m/%Y")

#Plot4
png("plot4.png")
par(mfrow=c(2,2))
plot(df$Time, df$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
plot(df$Time, df$Voltage, ylab="Voltage", xlab="datetime", type="l")
plot(c(df$Time, df$Time, df$Time), c(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3), type="n", ylab="Energy sub metering", xlab="")
points(df$Time, df$Sub_metering_1, col="black", type="l")
points(df$Time, df$Sub_metering_2, col="red", type="l")
points(df$Time, df$Sub_metering_3, col="blue", type="l")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty="n")
plot(df$Time, df$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")
dev.off()
