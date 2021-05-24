library(tidyverse)
library(plotly)
library(ggplot2)
install.packages("reshape2")
library(reshape2)
library(dplyr)

data <- read.csv("../shootings_wash_post.csv")
victim_data <- read.csv("victim_race_data.csv")
deatharrests_data <- read.csv("../deaths_arrests.csv")

#make dataframe for proportion of race according to US census:
#https://www.census.gov/quickfacts/fact/table/US/PST045219


#unknown race was not included as unable to accurately identify
#which US Census Race cateogory victims belong to.
Victim.s.race <- c("Asian", "Black", "Hispanic", "Native American",
          "Pacific Islander", "White")
proportion <- c(5.9, 13.4, 18.5, 1.3, 0.2, 60.1)

population_race <- data.frame(Victim.s.race, proportion)

totalvictims_race <- victim_data %>%
  group_by(Victim.s.race) %>%
  filter(Victim.s.race != "Unknown race")%>%
  summarize(totalnum = n()) %>%
  mutate(proportion = (totalnum / sum(totalnum)) * 100) 


deathvictims <- deatharrests_data %>%
  group_by(State) %>%
  
  

#combine the data sets
final_data <- merge(totalvictims_race, population_race,by= "Victim.s.race")
colnames(final_data) <- c("race", "totalnum","victim_prop",
                          "population_prop")
final_data_long <- 
  melt(final_data[, c("race", "population_prop", "victim_prop")],
       id.vars = 1)


#interactive visualization: compare population's race proportions with
#victims race proportion to see inequality
grouped_bar_chart<- ggplotly(
  ggplot(data = final_data_long, aes(x = race, y= value)) +
    geom_bar(aes(fill = variable), stat = "identity", position = "dodge") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    labs(
      title ="Proportion of Race Population vs. Proportion of Race of Victims",
      x = "Race",
      y = "Proportion (in Percent)",
      caption ="Source: US 2019 Census & Mapping Police Violence"))

#IDEAS FOR ANALYSIS:
#Even though Black people only take up 13.4% of the population, they take up
#27.97% of the victims, showing racial inequality in terms of police shootings