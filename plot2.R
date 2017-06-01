## Read the data first, if it has not yet been read. Will take a few seconds.
if (!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")}

if (!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")}

##Subset Baltimore City data, (fips == "24510"), then aggregate total emissions
##by year.
bcity <- subset(NEI, fips=="24510")
btotals <- aggregate(Emissions ~ year, data=bcity, sum)

##Open PNG and graph with appropriate labels. Turn off device after.
png("plot2.PNG")

barplot(height=btotals$Emissions/1000, names.arg=btotals$year,
        xlab="year", ylab="PM2.5 emissions in kilotons",
        main="Total PM2.5 emissions per year in Baltimore City, MD", col=btotals$year)

dev.off()
