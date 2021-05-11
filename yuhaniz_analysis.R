#Load packages
library(dplyr)
library(ggplot2)

#Load data
data <- read.csv("shootings_wash_post.csv", stringsAsFactors = FALSE)

data <- na.omit(data)

#Filtered table for race and signs of mental illness
data_up <- data %>%
  select(race, signs_of_mental_illness) %>%
  group_by(race)

#Dodge bar for race and signs of mental illness
dodge_bar <- ggplot(data_up, aes(factor(race), fill = factor(signs_of_mental_illness))) +
  geom_bar(position = "dodge") +
  labs(
    fill = "Signs of Mental Illness",
    title = "Victims shot by police comparing race and signs of mental illness",
    x = "Race",
    y = "Value"
  )


#How do I get rid of the blank race. And how can I rename A to Asian, B to Black, etc...
