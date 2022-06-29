library(tidyverse)

setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

res <- read.table ("household_power_consumption.txt", header=TRUE, sep=";", na.strings = c("?"),
colClasses=c("myDate", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

res <- res %>% filter(Date >= as.Date("01/02/2007", format="%d/%m/%Y") & Date <= as.Date("02/02/2007", format="%d/%m/%Y"))
      
res <- mutate (res, DateTime = strptime(paste(format(Date, "%d/%m/%Y"), Time), "%d/%m/%Y %H:%M:%S"))
str(res)
      
      
#Plot 3
plot(res$DateTime, res$Sub_metering_1, main = "", ylab = "Energy sub metering", xlab="", type="l")
lines(res$DateTime, res$Sub_metering_2, type="l", col="red")
lines(res$DateTime, res$Sub_metering_3, type="l", col="blue")
legend("topright", pch = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file ="plot3.png", width = 480, height = 480)
dev.off()
