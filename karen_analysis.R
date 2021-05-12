library(ggplot2)
library(tidyverse)

data_table <- read.csv("shootings_wash_post.csv")

data_table <- na.omit(data_table)

filtered_table <- data_table %>%
  select(body_camera, race, age, date) %>%
  filter(race != "")

filtered_table$race <- filtered_table$race %>%
  str_replace_all("A", "Asian") %>%
  str_replace_all("W", "White") %>%
  str_replace_all("H", "Hispanic") %>%
  str_replace_all("B", "Black") %>%
  str_replace_all("O", "Other") %>%
  str_replace_all("N", "Native American")
  

stacked_bar_chart <- ggplot(filtered_table, aes(age)) +
  geom_bar(aes(fill=race), width=0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) +
  scale_x_continuous(n.breaks = 25) +
  labs(title="Categorywise Bar Chart",
       x = "Age",
       y = "Number of Fatal Shootings",
       fill = "Race",
       subtitle="Shootings grouped by age and race", 
       caption="Source: Washington Post - Data Police Shootings") +
  scale_fill_manual(values = c("#FF8066", "#845EC2", "#FF6F91", "#F9F871", "#00C9A7", "#739DFF"))


stacked_bar_chart