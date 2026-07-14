## plot1.R
## Reconstructs a histogram of Global Active Power for 2007-02-01 and 2007-02-02

## ---- Read and subset the data ----
power <- read.table("household_power_consumption.txt",
                     header = TRUE, sep = ";", na.strings = "?",
                     colClasses = "character", stringsAsFactors = FALSE)

power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

subPower <- power[power$Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]

subPower$Global_active_power <- as.numeric(subPower$Global_active_power)

## ---- Construct the plot ----
png("plot1.png", width = 480, height = 480)

hist(subPower$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()
