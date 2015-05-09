## LIBRARIES USED
library(dplyr)

# File containing the dataset
file <- "household_power_consumption.txt"

# Setting up column classes for the dataset
dataClasses <- c("character", "character", "numeric", "numeric", "numeric"
                 , "numeric", "numeric", "numeric", "numeric")

# We read the dataframe (only the 2 days of data)
dataset <- read.table(file, header = FALSE, sep = ";", 
                      colClasses = dataClasses, na.strings = "?", skip = 66637,
                      nrows = 2880)
# We read the names
names(dataset) <- read.table(file, sep = ";", colClasses = "character", nrows = 1)

# We mutate Date and Time into a POSIXct variable named Date
dataset <- mutate(dataset, Date = paste(Date, Time))
dataset <- mutate(dataset, Date = as.POSIXct(strptime(Date, "%d/%m/%Y %H:%M:%S")))
dataset <- dataset[,-2]

# We filter the non complete cases
dataset <- dataset[complete.cases(dataset),]

png(file = "plot3.PNG")

with(dataset, plot(dataset$Date, dataset$Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering"))
with(dataset, lines(dataset$Date, dataset$Sub_metering_2, col = "red", type = "l"))
with(dataset, lines(dataset$Date, dataset$Sub_metering_3, col = "blue", type = "l"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty=c(1,1,1))

dev.off()