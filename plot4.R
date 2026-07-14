## plot4.R
## Reconstructs a 2x2 panel of plots:
##   (top-left)     Global Active Power vs. time
##   (top-right)    Voltage vs. time
##   (bottom-left)  Energy sub metering vs. time (with legend)
##   (bottom-right) Global Reactive Power vs. time

## ---- Read and subset the data ----
power <- read.table("household_power_consumption.txt",
                     header = TRUE, sep = ";", na.strings = "?",
                     colClasses = "character", stringsAsFactors = FALSE)

power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

subPower <- power[power$Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]

subPower$Global_active_power   <- as.numeric(subPower$Global_active_power)
subPower$Global_reactive_power <- as.numeric(subPower$Global_reactive_power)
subPower$Voltage               <- as.numeric(subPower$Voltage)
subPower$Sub_metering_1        <- as.numeric(subPower$Sub_metering_1)
subPower$Sub_metering_2        <- as.numeric(subPower$Sub_metering_2)
subPower$Sub_metering_3        <- as.numeric(subPower$Sub_metering_3)

datetime <- strptime(paste(subPower$Date, subPower$Time),
                      format = "%Y-%m-%d %H:%M:%S")

## ---- Construct the plot ----
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

## Top-left: Global Active Power
plot(datetime, subPower$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")

## Top-right: Voltage
plot(datetime, subPower$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")

## Bottom-left: Energy sub metering
plot(datetime, subPower$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(datetime, subPower$Sub_metering_2, col = "red")
lines(datetime, subPower$Sub_metering_3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

## Bottom-right: Global Reactive Power
plot(datetime, subPower$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
