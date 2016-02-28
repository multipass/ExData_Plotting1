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

#Plot2
png("plot2.png")
plot(df$Time, df$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.off()
