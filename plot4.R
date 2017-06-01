## Read the data first, if it has not yet been read. Will take a few seconds.
if (!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")}

if (!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")}

##Select only coal combustion related sources from SCC and subset this from NEI

coal<-grepl("Fuel Comb.*Coal", SCC$EI.Sector)
coalsub<- SCC[coal,]
emissions<- NEI[(NEI$SCC %in% coalsub$SCC),]

##Open PNG and graph. Remember to close device

png("plot4.png")

library(ggplot2)
g<-ggplot(emissions, aes(as.factor(year), Emissions/1000, fill=year))
g + geom_bar(stat="identity") + xlab("year") + ylab("PM25 Emissions in kilotons") +
        ggtitle("Coal Combustion Related Emissions by Year") + guides(fill=FALSE)


dev.off()