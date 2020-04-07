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
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data1, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

# Saving PNG File
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
