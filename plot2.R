library(tidyverse)

setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

res <- read.table ("household_power_consumption.txt", header=TRUE, sep=";", na.strings = c("?"),
colClasses=c("myDate", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

res <- res %>% filter(Date >= as.Date("01/02/2007", format="%d/%m/%Y") & Date <= as.Date("02/02/2007", format="%d/%m/%Y"))
      
res <- mutate (res, DateTime = strptime(paste(format(Date, "%d/%m/%Y"), Time), "%d/%m/%Y %H:%M:%S"))
str(res)
      
#Plot 2
with(res, plot(DateTime, Global_active_power, main = "", ylab = "Global Active Power (kilowatts)", xlab="", type="l"))
dev.copy(png, file ="plot2.png", width = 480, height = 480)
dev.off()
    