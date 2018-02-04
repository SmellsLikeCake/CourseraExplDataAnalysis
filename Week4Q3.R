## Exploratory Data Analysis Homework Week 4

## Question 3

## Read in data
em_data <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## Subset data to fips == 24510
bc <- subset(em_data, fips == "24510")

## Load in libraries
library(ggplot2)
library(tidyr)
library(dplyr)

## Manipulate data
bc$year <- as.factor(bc$year)
bc$type <- as.factor(bc$type)
bc_type <- group_by(bc, type, year)
bc_type <- mutate(bc_type, total_em = sum(Emissions))
bc_type <- select(bc_type, c(5:7))
bc_type <- unique(bc_type)

## Plot graph
png("BCEmissionsByType.png", width = 480, height = 480, units = "px")
ggplot(bc_type, aes(year, total_em)) + geom_point() + facet_grid(.~type)
dev.off()
