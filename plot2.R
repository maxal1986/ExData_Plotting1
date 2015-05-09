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

png(file = "plot2.PNG")

plot(dataset$Date, dataset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")


dev.off()