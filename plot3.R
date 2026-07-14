## plot3.R
## Reconstructs a line plot of the three energy sub-metering
## variables for 2007-02-01 and 2007-02-02

## ---- Read and subset the data ----
power <- read.table("household_power_consumption.txt",
                     header = TRUE, sep = ";", na.strings = "?",
                     colClasses = "character", stringsAsFactors = FALSE)

power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

subPower <- power[power$Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]

subPower$Sub_metering_1 <- as.numeric(subPower$Sub_metering_1)
subPower$Sub_metering_2 <- as.numeric(subPower$Sub_metering_2)
subPower$Sub_metering_3 <- as.numeric(subPower$Sub_metering_3)

datetime <- strptime(paste(subPower$Date, subPower$Time),
                      format = "%Y-%m-%d %H:%M:%S")

## ---- Construct the plot ----
png("plot3.png", width = 480, height = 480)

plot(datetime, subPower$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(datetime, subPower$Sub_metering_2, col = "red")
lines(datetime, subPower$Sub_metering_3, col = "blue")

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

dev.off()
