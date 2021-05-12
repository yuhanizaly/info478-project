#Load Packages
library(tidyverse)

#Load and Filter Data
data <- read.csv("shootings_wash_post.csv")

data$date <- as.Date(data$date)
data$year <- as.numeric(format(data$date, format = "%Y"))

boxplot_data <- data %>%
  dplyr::select(name, state, year) %>%
  group_by(year, state) %>%
  summarise(total = n()) %>%
  dplyr::select(year, total)

#Boxplot
boxplot <- ggplot(boxplot_data, aes(x = as.character(year), y = total, group = as.character(year))) +
  geom_boxplot(mapping = aes(fill = as.character(year))) +
  scale_fill_brewer(palette = "Paired") +
  labs(
    title = "Average Number of Fatal Shootings by Police Across the U.S.",
    x = "Year",
    y = "Number of Fatal Shootings",
    caption = "Source: Washington Post - Data Police Shootings"
  ) +
  theme(legend.position = "none")

# Over the years, the average number of fatal shootings by police offers has remained relatively consistent.
#What is most interesting about the way fatal shootings have been distributed across years is that the outlier amounts have changed drastically from year to year.
#Each point represents an individual state, which means that certain states do fluctuate a lot in their fatal shooting rate.
#It is also interesting to note that in 2020, there was a lower number of fatal shootings, despite the increased attention to police brutality and the Black Lives Matter movement.
#Part of this may be due to the fact that the pandemic impacted the number of shootings that occurred in general.
#This graph also represents the national average, and does not take into account inequality, which has been one of the primary issues in policy brutality.
