

### Download data

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile="household_power_consumption.zip"  
download.file(fileURL, destfile=zipfile)
unzip(zipfile)

### Read data into data frames
first_row <-    read.table ("household_power_consumption.txt", sep=";", nrows=1,stringsAsFactors=FALSE)
power <-        read.table ("household_power_consumption.txt", col.names=first_row, sep=";", na.strings="?", 
                            skip=66637, nrows=2880, stringsAsFactors=FALSE)
                                       ###### 2880=2 days x 24 hrs x 60 min

### Add a new column with date format called "datetime" and convert "Date" and "Time" into it
power$datetime <- strptime (paste (power$Date,power$Time),"%d/%m/%Y %H:%M:%S")


### Do the plot
par(mfrow= c(2,2), bg="transparent")

with(power,{
        plot (x = datetime, y = Global_active_power, type = "n",ylab = "Global Active Power" ,xlab="")
        lines(x = datetime, y = Global_active_power )
        
        plot (x = datetime, y = Voltage, type = "n",ylab = "Voltage" ,xlab="datetime")
        lines(x = datetime, y = Voltage )
        
        plot (x = datetime, y = Sub_metering_1, type = "n",ylab = "Energy sub metering" ,xlab="")
        lines(x = datetime, y = Sub_metering_1 )
        lines(x = datetime, y = Sub_metering_2, col="red" )
        lines(x = datetime, y = Sub_metering_3, col="blue" )
        legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                          lty=c("solid","solid","solid"),col=c("black","red","blue"),bty="n",y.intersp=0.8)
        
        plot (x = datetime, y = Global_reactive_power, type = "n",ylab = "Global_reactive_power" ,xlab="datetime")
        lines(x = datetime, y = Global_reactive_power )
        })

### Copy the plot from the screen to a png file
dev.copy(png,file="plot4.png",width = 480, height = 480, units = "px", res=54, bg="transparent")
dev.off()
