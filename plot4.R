##Read data in R

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## Subset coal combustion data
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalcombustion <- (combustion & coal)
ccSCC <- SCC[coalcombustion,]$SCC

##Filter NEI for coal combustion sources
ccNEI <- NEI[NEI$SCC %in% ccSCC,]

##Sum by year
aggregatecc <- aggregate(ccNEI$Emissions, list(ccNEI$year), FUN= "sum")

##Rename columns
names(aggregatecc) <- c("year", "Emissions")

##Create Plot
png(filename = "plot4.png",width = 480, height = 480,units = "px")
g<-ggplot(aggregatecc, aes(year, Emissions))
g+geom_line()+ xlab("Year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
 ggtitle("Emissions from coal combustion sources in the US from 1999-2008")
dev.off()





