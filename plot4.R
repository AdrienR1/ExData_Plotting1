library(tidyverse)

setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

res <- read.table ("household_power_consumption.txt", header=TRUE, sep=";", na.strings = c("?"),
colClasses=c("myDate", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

res <- res %>% filter(Date >= as.Date("01/02/2007", format="%d/%m/%Y") & Date <= as.Date("02/02/2007", format="%d/%m/%Y"))
      
res <- mutate (res, DateTime = strptime(paste(format(Date, "%d/%m/%Y"), Time), "%d/%m/%Y %H:%M:%S"))
str(res)

#Plot 4
par(mfrow = c(2, 2))
with(res, {
    plot(DateTime, Global_active_power, main = "", ylab = "Global Active Power (kilowatts)", xlab="", type="l")
    plot(res$DateTime, res$Voltage, main = "", ylab = "Voltage", type="l")
    plot(res$DateTime, res$Sub_metering_1, main = "", ylab = "Energy sub metering", type="l")
    lines(res$DateTime, res$Sub_metering_2, type="l", col="red")
    lines(res$DateTime, res$Sub_metering_3, type="l", col="blue")
    plot(DateTime, Global_reactive_power, main = "", type="l")
})
dev.copy(png, file ="plot4.png", width = 480, height = 480)
dev.off()