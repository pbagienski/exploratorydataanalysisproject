## Read the data first, if it has not yet been read. Will take a few seconds.
if (!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")}

if (!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")}


##Subset Baltimore City data, (fips == "24510"), for ON-ROAD type (vehicles),
##and aggregate the total. Add a city name category to the result.
baltroad <- subset(NEI, fips=="24510" & type=="ON-ROAD")
balttot <-aggregate(Emissions~year,data=baltroad,sum)
balttot$city <- c("Baltimore City, MD")

##Do the same for Los Angeles county (fips == "06037")
laroad <- subset(NEI, fips=="06037" & type=="ON-ROAD")
latot <-aggregate(Emissions~year,data=laroad,sum)
latot$city <- c("Los Angeles County, CA")


##Combine the data
both <- rbind(balttot, latot)

##Open PNG and graph. Remember to close device

png("plot6.png")

library(ggplot2)
g<-ggplot(both, aes(as.factor(year), Emissions/1000, fill=city))
g + geom_bar(stat="identity") + xlab("year") + ylab("PM25 Emissions in kilotons") +
        ggtitle("Comparison of Baltimore City and Los Angeles County Vehicle Emissions") +
        facet_grid(city~., scales="free")


dev.off()