##Read data in R

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset for Baltimore City, fips==24510

baltimore <- NEI[NEI$fips== "24510", ]

## Calculate total emissions in Baltimore city by year and type

balemissions <- aggregate(baltimore$Emissions, list(baltimore$year, baltimore$type), FUN = "sum")

##Rename columns
names(balemissions) <- c("Year", "Type", "Emissions")

##Load ggplot2
install.packages("ggplot2")
library(ggplot2)

##Create plot 

png(filename = "plot3.png",width = 480, height = 480,units = "px")
g<- ggplot(balemissions, aes(Year,Emissions))
  g+geom_line(aes(color=Type))+facet_grid(.~Type)+ xlab("Year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle("Total Emissions in Baltimore City from 1999 to 2008 by Source Type")
dev.off()

