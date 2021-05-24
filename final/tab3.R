library(tidyverse)
library(plotly)
library(openintro)

#Load Data
setwd("~/Desktop/INFO478/info478-project")
data <- read.csv("shootings_wash_post.csv")

#Filter Data
filtered_data <- data %>%
  filter(race == c("W", "B"),
         body_camera == T) %>%
  group_by(state, race) %>%
  summarise(total = length(race)) %>%
  spread(key = race,
         value = total)

filtered_data$state <- abbr2state(filtered_data$state)

#Graph
graph <- ggplot(data = filtered_data) +
  geom_point(mapping = aes(x = B, y = W, fill = state), size = 1.75) +
  xlim(NA, 90) +
  ylim(NA, 90) +
  geom_abline(intercept = 0, slope = 1) +
  labs(title = "Number of White and Black People Killed by Police Without a Body Camera",
       x = "Number of Black People Killed",
       y = "Number of White People Killed") +
  theme(legend.position = "none")

graph <- ggplotly(graph)
