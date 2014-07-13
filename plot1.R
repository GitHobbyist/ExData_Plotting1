plot1 <- function() {
        
        filePath <- paste(getwd(),"/exdata_data_household_power_consumption.zip",
                          sep="")
        fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        
        ##Check if download of file is needed 
        if (!file.exists(filePath)) {
                
                download.file(fileURL,destfile=filePath)
                
        }
        
        ##Read file and trim dataset based on desired dates.       
        data <- subset(read.table(unz(filePath,"household_power_consumption.txt"),
                                  header=TRUE,sep=";",na.strings="?"),
                       Date == "1/2/2007" | Date == "2/2/2007" )
        
        
        ##Plot graph
        par(mar= c(4,4,4,2),oma= c(0,0,2,0))
        hist(data[,"Global_active_power"], col = "red", 
             xlab = "Global Active Power (kilowatts)", 
             main = "Global Active Power", 
             cex.lab= 0.7,cex.axis=0.7,cex.main=0.8,
             font.lab=2,font.axis=2)
        mtext("Plot 1",side=3,outer=TRUE,adj=0,font=2,cex=0.8)
        
        
        ##Show and save copy to disk of graph as .png file
        dev.copy(png,file= "plot1.png",width = 480, height = 480)
        dev.off()
        
}