## plot2.R
## Reconstructs a line plot of Global Active Power vs. time
## for 2007-02-01 and 2007-02-02

## ---- Read and subset the data ----
power <- read.table("household_power_consumption.txt",
                     header = TRUE, sep = ";", na.strings = "?",
                     colClasses = "character", stringsAsFactors = FALSE)

power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

subPower <- power[power$Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]

subPower$Global_active_power <- as.numeric(subPower$Global_active_power)

## Combine Date and Time into a single Date/Time object
datetime <- strptime(paste(subPower$Date, subPower$Time),
                      format = "%Y-%m-%d %H:%M:%S")

## ---- Construct the plot ----
png("plot2.png", width = 480, height = 480)

plot(datetime, subPower$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()
