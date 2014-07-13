plot4 <- function() {
        
        filePath <- paste(getwd(),"/exdata_data_household_power_consumption.zip",
                          sep="")
        fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        
        ##Check if download of file is needed 
        if (!file.exists(filePath)) {
                
                download.file(fileURL,destfile=filePath)
                
        }
        
        ##Read file and trim dataset with desired dates.       
        data <- subset(read.table(unz(filePath,"household_power_consumption.txt"),
                       header=TRUE,sep=";",na.strings="?"),
                       Date == "1/2/2007" | Date == "2/2/2007" )
        
        ##Convert to date/time types
        data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
        data$Date <- as.Date(data$Date, "%d/%m/%Y")
        
        lgdNames <- names(data)
        
        
        ##Plot graph
        par(mfcol = c(2,2), mar= c(4,4,2,2),oma= c(0,0,2,0))
        with(data, {
                plot(Time,Global_active_power,type="l",ylab = "Global Active Power (kilowatts)",
                     xlab="", cex.lab= 0.7,cex.axis=0.7,cex.main=0.8,
                     font.lab=2,font.axis=2,lwd=2)
                plot(Time,Sub_metering_1,type="l",col="gray60",xlab="",
                     ylab = "Energy sub metering",cex.lab= 0.7,cex.axis=0.7,
                     cex.main=0.8,font.lab=2,font.axis=2,lwd=2)
                points(Time,Sub_metering_2,type="l",col="orangered2")
                points(Time,Sub_metering_3,type="l",col="blue")
                legend("topright",lwd=2 , col= c("gray60","orangered2","blue"),
                legend=lgdNames[c(7,8,9)],cex=0.7,pt.cex=2,text.font=2,bty="n")
                plot(Time,Voltage,type="l",xlab = "datetime",ylab = "Voltage",
                     cex.lab= 0.7,cex.axis=0.7,cex.main=0.8,font.lab=2,
                     font.axis=2,lwd=2)
                plot(Time,Global_reactive_power,type="l",xlab = "datetime",
                     cex.lab= 0.7,cex.axis=0.7,cex.main=0.8,font.lab=2,
                     font.axis=2)
                mtext("Plot 4",side=3,outer=TRUE,adj=0,font=2,cex=0.8)
        })
        
        ##Show and save copy to disk of graph as .png file
        dev.copy(png,file= "plot4.png",width = 480, height = 480)
        dev.off()
        
}