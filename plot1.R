## Read the data first, if it has not yet been read. Will take a few seconds.
if (!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")}

if (!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")}

##Aggregate total emissions by year.
yeartotals <- aggregate(Emissions ~ year, data=NEI, sum)

##Open PNG and graph with appropriate labels. Turn off device after.
png("plot1.PNG")

barplot(height=yeartotals$Emissions/1000, names.arg=yeartotals$year,
        xlab="year", ylab="PM2.5 emissions in kilotons",
        main="Total PM2.5 emissions per year", col=yeartotals$year)

dev.off()
