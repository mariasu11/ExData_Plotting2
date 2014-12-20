##Read data in R

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Calculate total emissions by year

totalEmissions <- aggregate(NEI$Emissions, list(NEI$year), FUN = "sum")

##Create Plot

png(filename = "plot1.png",width = 480, height = 480,units = "px")

plot(totalEmissions, type = "l", xlab = "Year", 
     main = "Total Emissions in the United States from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))
dev.off()