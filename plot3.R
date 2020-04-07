# Import downloaded data
# The file should be downloaded and selected in this process
data1 <- read.table(file.choose(), header=TRUE, sep=";", dec=".", na.strings = "?",
                colClasses = c('character','character','numeric','numeric','numeric',
                               'numeric','numeric','numeric','numeric'))

# Get the needed subset of data and Perform Preparation for Plotting
data1$Date <- as.Date(data1$Date, "%d/%m/%Y")
data1 <- subset(data1,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
data1 <- data1[complete.cases(data1),]
dateTime <- paste(data1$Date, data1$Time)
dateTime <- setNames(dateTime, "DateTime")
data1 <- data1[ ,!(names(data1) %in% c("Date","Time"))]
data1 <- cbind(dateTime, data1)
data1$dateTime <- as.POSIXct(dateTime)
attach(data1)

# Produce Graph
  with(data1, {
    plot(Sub_metering_1~dateTime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~dateTime,col='Red')
    lines(Sub_metering_3~dateTime,col='Blue')
  })
  legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Saving PNG File
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
