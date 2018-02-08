## Exploratory Data Analysis Homework Week 4

## Question 4

## Libraries
library(ggplot2)
library(dplyr)
library(tidyr)

## Read in data
em_data <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## Find which rows are coal
scc_coal_l <- grepl("Coal", scc$EI.Sector, ignore.case = TRUE)
scc_coal <- scc[scc_coal_l, ]
scc_coal <- scc_coal[, c(1, 3)]

## Manipulate emissions data for coal
em_data_coal <- merge(scc_coal, em_data)
em_data_coal <- group_by(em_data_coal, year)
em_data_coal <- mutate(em_data_coal, total_em_year = sum(Emissions))
em_data_coal <- group_by(em_data_coal, SCC, year)
em_data_coal <- mutate(em_data_coal, total_em_SCC_year = sum(Emissions))
em_data_coal$year <- as.factor(em_data_coal$year)

## Separate by year
em_data_coal_1999 <- filter(em_data_coal, year == 1999)
em_data_coal_2002 <- filter(em_data_coal, year == 2002)
em_data_coal_2005 <- filter(em_data_coal, year == 2005)
em_data_coal_2008 <- filter(em_data_coal, year == 2008)

## Try base plotting and segments
plot(em_data_coal_1999$year, log10(em_data_coal_1999$total_em_SCC_year), xlim = c(1999, 2008))
points(em_data_coal_2002$year, log10(em_data_coal_2002$total_em_SCC_year))
segments(em_data_coal_1999$year, log10(em_data_coal_1999$total_em_SCC_year), em_data_coal_2002$year, log10(em_data_coal_2002$total_em_SCC_year))
## Hard to see much

## Try ggplot with colours
ggplot(em_data_coal, aes(year, total_em_SCC_year, colour = SCC)) + geom_line()
## Hard to see because of scale, try log
ggplot(em_data_coal, aes(year, log10(total_em_SCC_year), colour = SCC)) + geom_line()
## Too much going on

## Just look at totals for each year instead
em_data_coal_year <- unique(em_data_coal[, 7:8])
plot(em_data_coal_year$year, em_data_coal_year$total_em_year)

## Try stacked
ggplot(em_data_coal, aes(x = year, y = Emissions)) + geom_bar(stat = "identity")

## Split by SCC - which sources have biggest impact?
png("Q4-CoalEmissions.png", height = 480, width = 480, units = "px")
ggplot(em_data_coal, aes(x = year, y = Emissions)) + geom_bar(stat = "identity", aes(fill = SCC))
dev.off()

