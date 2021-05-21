library(tidyverse)
library(plotly)

#Load Data
setwd("~/Desktop/INFO478/info478-project")
data <- read.csv("shootings_wash_post.csv")

#Filter Data
filtered_data <- data %>%
  filter(race == c("A", "B"),
         body_camera == F) %>%
  group_by(state, race) %>%
  summarise(total = length(race)) %>%
  spread(key = race,
         value = total)

#Graph
graph <- ggplot(data = filtered_data) +
  geom_point(mapping = aes(x = B, y = A)) +
  xlim(NA, 90) +
  ylim(NA, 90) +
  geom_abline(intercept = 0, slope = 1)

graph <- ggplotly(graph)
