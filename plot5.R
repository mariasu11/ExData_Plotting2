##Read data in R

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset for Baltimore City, fips==24510

baltimore <- NEI[NEI$fips== "24510", ]

##Subset for motor vehicle sources
motorv <- grepl("motor", SCC$Short.Name, ignore.case = TRUE)
motorsubset <- SCC[motorv, ]$SCC

##Filter NEI for motor vehicle sources
motorNEI <- baltimore[baltimore$SCC %in% motorsubset, ]

##Sum emissions by year
aggregatemotor <- aggregate(motorNEI$Emissions, list(motorNEI$year), FUN = "sum")


##Rename columns
names(aggregatemotor) <- c("year", "Emissions")

##Create Plot
library(ggplot2)
png(filename = "plot5.png",width = 480, height = 480,units = "px")
g<-ggplot(aggregatemotor, aes(year, Emissions))
g+geom_line()+ xlab("Year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
 ggtitle("Change in emissions from motor vehicle sources from 1999-2008")
dev.off()
