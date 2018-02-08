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

## Some rows are totals! Remove totals or will double count.
scc_vehicle_total_l <- grepl("total", scc_vehicle$SCC.Level.Four, ignore.case = TRUE)
scc_vehicle <- scc_vehicle[!scc_vehicle_total_l, ]
scc_vehicle <- scc_vehicle[, 1:3]

## Merge with em_data
em_data_vehicle <- merge(em_data, scc_vehicle)

## Baltimore City only
em_data_vehicle_bc <- em_data_vehicle[em_data_vehicle$fips == "24510", ]
em_data_vehicle_bc$year <- as.factor(em_data_vehicle_bc$year)

## Plot graph
png("Q5-MotorVehiclesInBC.png", width = 480, height = 480, units = "px")
ggplot(em_data_vehicle_bc, aes(x = year, y = Emissions)) + geom_bar(stat = "identity", aes(fill = SCC)) + guides(fill = FALSE)
dev.off()