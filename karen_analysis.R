library(ggplot2)
library(dplyr)

data_table <- read_csv("shootings_wash_post.csv")

data_table <- na.omit(data_table)

filtered_table <- data_table %>% select(body_camera, race, age, date)

ggplot(data = filtered_table) +
  geom_point(mapping = aes(x=date, y=race, size=age))


stacked_bar_chart <- ggplot(filtered_table, aes(age)) +
  geom_bar(aes(fill=race), width=0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) +
  scale_x_continuous(n.breaks = 25) +
  labs(title="Categorywise Bar Chart", 
       subtitle="Shootings grouped by age and race", 
       caption="Source: Washington Post - Data Police Shootings") +
  scale_fill_manual(values = c("#FF8066", "#845EC2", "#FF6F91", "#F9F871", "#00C9A7", "#739DFF"));


stacked_bar_chart