## Read the data first, if it has not yet been read. Will take a few seconds.
if (!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")}

if (!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")}


##Subset Baltimore City data, (fips == "24510"), then aggregate total emissions
##by year and type.
bcity <- subset(NEI, fips=="24510")
byeartype <- aggregate(Emissions ~ year + type, data=bcity, sum)


##Open PNG and graph with appropriate labels. Turn off device after.
png("plot3.PNG")

library(ggplot2)
g<-ggplot(byeartype, aes(as.factor(year), Emissions/1000, fill=type))
g + geom_bar(stat="identity") + xlab("year") + ylab("PM25 Emissions in kilotons") +
        ggtitle("Total PM25 Emissions in Baltimore City, MD") + facet_grid(.~type)


dev.off()
