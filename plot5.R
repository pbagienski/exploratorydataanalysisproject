## Read the data first, if it has not yet been read. Will take a few seconds.
if (!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")}

if (!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")}


##Subset Baltimore City data, (fips == "24510"), for ON-ROAD type (vehicles),
##and aggregate the total.
baltroad <- subset(NEI, fips=="24510" & type=="ON-ROAD")
roadtotal <-aggregate(Emissions~year,data=baltroad,sum)

##Open PNG and graph. Remember to close device

png("plot5.png")

library(ggplot2)
g<-ggplot(roadtotal, aes(as.factor(year), Emissions/1000, fill=year))
g + geom_bar(stat="identity") + xlab("year") + ylab("PM25 Emissions in kilotons") +
        ggtitle("Baltimore City Vehicle Emissions by Year") + guides(fill=FALSE)


dev.off()