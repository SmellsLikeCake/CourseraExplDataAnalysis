## Exploratory Data Analysis Homework Week 4

## Question 2

## Read in data
em_data <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## Subset data to fips == 24510
bc <- subset(em_data, fips == "24510")

## Manipulate data
bc$year <- as.factor(bc$year)
bc_by_year <- tapply(bc$Emissions, bc$year, sum)

## Create plot
png("BaltimoreCityEmissions.png", width = 480, height = 480, units = "px")
barplot(bc_by_year, main = "Emissions in Baltimore City, Maryland", ylab = "Emissions in tons")
dev.off()