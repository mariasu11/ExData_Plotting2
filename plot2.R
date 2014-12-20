##Read data in R

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset for Baltimore City, fips==24510

baltimore <- NEI[NEI$fips== "24510", ]

## Calculate total emissions in Baltimore city by year

balemissions <- aggregate(baltimore$Emissions, list(baltimore$year), FUN = "sum")

##Create Plot

png(filename = "plot2.png",width = 480, height = 480,units = "px")

plot(balemissions, type = "l", xlab = "Year", 
     main = "Total Emissions in Baltimore City from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))
dev.off()

