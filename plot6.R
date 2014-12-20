##Read data in R

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset for Baltimore City, fips==24510 & Los Angeles County, fips==06037

baltimoreLA <- NEI[NEI$fips== "24510" | NEI$fips=="06037" , ]

##Subset for motor vehicle sources
motorv <- grepl("motor", SCC$Short.Name, ignore.case = TRUE)
motorsubset <- SCC[motorv, ]$SCC

##Filter NEI for motor vehicle sources in Baltimore and LA
motorNEI <- baltimoreLA[baltimoreLA$SCC %in% motorsubset, ]

##Sum emissions by year and fips
aggregatebalLA <- aggregate(motorNEI$Emissions, list(motorNEI$year, motorNEI$fips), FUN = "sum")

##Rename columns
names(aggregatebalLA) <- c("year", "fips", "Emissions")

##Create Plot
library(ggplot2)
par("mar"=c(0,0,0,0))
png(filename = "plot6.png",width = 480, height = 480,units = "px")
g<-ggplot(aggregatebalLA, aes(year, Emissions))
g+geom_line(aes(color=fips))+ xlab("Year") + ylab(expression('Total PM'[2.5]*" Emissions From Motor Vehicle(MV)sources")) +
 ggtitle("Emissions comparison in Balt City and LA Cnty from MV sources from 1999-2008")
dev.off()