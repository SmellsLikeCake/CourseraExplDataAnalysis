## Exploratory Data Analysis Homework Week 4

## Question 1

## Read in data
em_data <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## Manipulate data
em_data$year <- as.factor(em_data$year)
year_totals <- tapply(em_data$Emissions, em_data$year, sum)

## Create plot
png(filename = "TotalEmissionsByYear.png", width = 480, height = 480, units = "px")
barplot(year_totals, ylab = "Total emissions in tons")
dev.off()