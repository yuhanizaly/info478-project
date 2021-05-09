#Load Packages
library(tidyverse)

#Load and Filter Data
data <- read.csv("deaths_arrests.csv")
data2 <- read.csv("shootings_wash_post.csv")

filtered_data <- data %>%
  select(State, Avg.Annual.Police.Homicide.Rate) %>%
  group_by(State) %>%
  summarise(avg_rate = round(mean(Avg.Annual.Police.Homicide.Rate), digits = 2))

data2$date <- as.Date(data2$date)
data2$year <- as.numeric(format(data2$date, format = "%Y"))

boxplot_data <- data2 %>%
  select(name, state, year) %>%
  group_by(year, state) %>%
  summarise(total = n()) %>%
  select(year, total)

boxplot <- ggplot(boxplot_data, aes(x = year, y = total, group = year)) +
  geom_boxplot() +
  scale_fill_brewer(palette = "Paired")


