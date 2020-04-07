# Import downloaded data
data1 <- read.table(file.choose(), header=TRUE, sep=";", dec=".", na.strings = "?",
                colClasses = c('character','character','numeric','numeric','numeric',
                               'numeric','numeric','numeric','numeric'))

# Get the needed subset of data
data1$Date <- as.Date(data1$Date, "%d/%m/%Y")
data1 <- subset(data1,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
data1 <- na.omit(data1, na.action = "omit")
head(data1)
attach(data1)

# Produce Graph
hist(Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

# Saving PNG File
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
