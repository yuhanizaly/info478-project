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
    y = "Number of Fatal Shootings"
  ) +
  theme(legend.position = "none")
#use fig.cap argument in r markdown to add that data points represent individual states

