## Exploratory Data Analysis Homework Week 4

## Question 5

## Libraries
library(ggplot2)
library(dplyr)
library(tidyr)

## Read in data
em_data <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## Have a look at sources
unique(scc$EI.Sector)

## Use word "vehicle" to find relevant rows
scc_vehicle_l <- grepl("vehicle", scc$EI.Sector, ignore.case = TRUE)
scc_vehicle <- scc[scc_vehicle_l, ]

## Don't need to remove totals- just different ways of recording in different years

## Merge with em_data
em_data_vehicle <- merge(em_data, scc_vehicle)

## Baltimore City and Los Angeles only
em_data_vehicle_bcla <- em_data_vehicle[em_data_vehicle$fips == "06037" | em_data_vehicle$fips == "24510" , ]
em_data_vehicle_bcla$year <- as.factor(em_data_vehicle_bcla$year)

## Plot graph
png("Q6-BaltimoreCityVLosAngeles.png", width = 480, height = 480, units = "px")
ggplot(em_data_vehicle_bcla, aes(x = year, y = Emissions)) + geom_bar(stat = "identity", aes(fill = fips)) + facet_grid(fips ~.)
dev.off()