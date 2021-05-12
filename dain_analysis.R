library("dplyr")
library("tidyr")
library("ggplot2")
library("plotly")


victim_race_data <- read.csv("police_killings_MPV.csv")
victim_race_data <- victim_race_data %>%
  select(Victim.s.race, Victim.s.gender, Date.of.Incident..month.day.year.,
         City, State) %>%
  mutate(year = substring(Date.of.Incident..month.day.year., 7, 10))


#TOTAL
#distribution of proportion of race of victims from 2013 - 2019
totalvictims_race <- victim_race_data %>%
  group_by(Victim.s.race) %>%
  summarize(totalnum = n()) %>%
  mutate(proportion = totalnum / sum(totalnum))

totalprop_race <- ggplot(data = totalvictims_race,
                                  aes(x = Victim.s.race, y = proportion,
                                      fill = Victim.s.race)) +
                             geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90,
                                   hjust = 1)) +
                             labs(title = "Proportion of Victims in Police
                             Killings by Race",
                                  x = "Victim's Race",
                                  fill = "Race",
                                  y = "Proportion",
                                  caption ="Source: Mapping Police Violence")

#From the data given we can see that the top 3 races of victims in police
#killings from 2013 to 2020 are White (44%), Black (25.2%) and Hispanic (17.2%).
#This could be due to a variety of reasons such as geographic location,
#race demographics, and number of crimes committed by race. Low proportions
#in victims of certain races such as Asians and Native Americans could be
#explained by small population numbers from people of that race.

#BY YEAR (eg. 2020)

#function for distribution of race of victims in a year
proportion_year_fn <- function(year_used) {
  prop_by_year <- victim_race_data %>%
    filter(year == year_used) %>%
    group_by(Victim.s.race) %>%
    summarise(totalnum = n()) %>%
    mutate(proportion = totalnum / sum(totalnum))
  prop_by_year
}

plot_2020 <- ggplotly(ggplot(data = proportion_year_fn(2020),
                    aes(x = Victim.s.race, y = proportion,
                        fill = Victim.s.race)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Proportion of Victims in Police Killings by Race in 2020"))



#Mean and sd of number of killings per year
killings_per_year <- victim_race_data %>%
  group_by(year) %>%
  summarise(total_inyear = n()) %>%
  mutate(mean = mean(total_inyear)) %>%
  mutate(sd = sd(total_inyear))



#Mean = 1053.375, sd = 113.3095
