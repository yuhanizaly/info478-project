library(tidyverse)
library(plotly)
library(ggplot2)
library(reshape2)
library(dplyr)
library(data.table)


deatharrests_data <- read.csv("../deaths_arrests.csv")




#unknown race was not included

deathvictims <- deatharrests_data %>%
  select(State, Black.People.Killed.by.Police..1.1.2013.12.31.2019.,
         Hispanic.People.Killed.by.Police..1.1.2013.12.31.2019.,
         Native.American.People.Killed.by.Police..1.1.2013.12.31.2019.,
         Asian.People.Killed.by.Police..1.1.2013.12.31.2019.,
         Pacific.Islanders.Killed.by.Police..1.1.2013.12.31.2019.,
         White.People.Killed.by.Police..1.1.2013.12.31.2019.,
         Black, White, Amer..Indian, Asian, Hawaiian, Hispanic, Total)
colnames(deathvictims) <- c("State", "black_victims", "hispanic_victims",
                            "native_amer_victims", "asian_victims",
                            "pacific_isl_victims", "white_victims",
                            "black_pop", "white_pop", "native_pop", "asian_pop",
                            "pacific_isl_pop", "hispanic_pop", "total_pop")
deathvictims[is.na(deathvictims)] = 0
deathvictims$black_pop <- as.numeric(gsub(",","",deathvictims$black_pop))
deathvictims$white_pop <- as.numeric(gsub(",","",deathvictims$white_pop))
deathvictims$native_pop <- as.numeric(gsub(",","",deathvictims$native_pop))
deathvictims$asian_pop <- as.numeric(gsub(",","",deathvictims$asian_pop))
deathvictims$pacific_isl_pop <-
  as.numeric(gsub(",","",deathvictims$pacific_isl_pop))
deathvictims$hispanic_pop <- as.numeric(gsub(",","",deathvictims$hispanic_pop))
deathvictims$total_pop <- as.numeric(gsub(",","",deathvictims$total_pop))


deathvictims_prop <- deathvictims %>%
  group_by(State) %>%
  summarise_at(c("black_victims", "hispanic_victims",
                 "native_amer_victims", "asian_victims",
                 "pacific_isl_victims", "white_victims",
                 "black_pop", "white_pop", "native_pop", "asian_pop",
                 "pacific_isl_pop", "hispanic_pop", "total_pop"),
               sum) %>%
  group_by(State) %>%
  mutate(total_victims_state = sum(black_victims, hispanic_victims,
                             native_amer_victims, asian_victims,
                             pacific_isl_victims, white_victims)) %>%
  mutate(black_vic_prop = (black_victims / total_victims_state) * 100,
         hisp_vic_prop = (hispanic_victims / total_victims_state) *100,
         native_vic_prop = (native_amer_victims / total_victims_state) * 100,
         asian_vic_prop = (asian_victims / total_victims_state) * 100,
         pac_vic_prop = (pacific_isl_victims / total_victims_state) * 100,
         white_vic_prop = (white_victims / total_victims_state) * 100,
         black_pop_prop = (black_pop / total_pop) * 100,
         hisp_pop_prop = (hispanic_pop / total_pop) * 100,
         native_pop_prop = (native_pop / total_pop) * 100,
         asian_pop_prop = (asian_pop / total_pop) * 100,
         pac_pop_prop = (pacific_isl_pop / total_pop) * 100,
         white_pop_prop = (white_pop / total_pop) * 100) %>%
  select(black_vic_prop, hisp_vic_prop, native_vic_prop, asian_vic_prop,
         pac_vic_prop, white_vic_prop, black_pop_prop, hisp_pop_prop,
         native_pop_prop, asian_pop_prop, pac_pop_prop, white_pop_prop)
  
  
deathvictims_prop <- deathvictims_prop[-c(1, 34), ]


#filter by state
plot_data <- deathvictims_prop %>%
  filter(State == "Alabama")

plot_data_transpose <- transpose(plot_data) %>%
  mutate(proportion = c("state", "black_vic_prop", "hisp_vic_prop",
                        "native_vic_prop", "asian_vic_prop","pac_vic_prop",
                        "white_vic_prop", "black_pop_prop", "hisp_pop_prop",
                        "native_pop_prop", "asian_pop_prop", "pac_pop_prop",
                        "white_pop_prop"))
 
plot_data_transpose <-  plot_data_transpose[-c(1),] 
colnames(plot_data_transpose) <- c("percent", "proportion")

chart<-
  ggplotly(ggplot(data = plot_data_transpose, aes(x = proportion, y = percent,
                                                  fill = percent)) +
    geom_bar(stat = "identity", position = "dodge") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    labs(
      title ="Proportion of Race Population vs. Proportion of Race of Victims",
      x = "Race",
      y = "Proportion (in Percent)",
      caption ="Source: Death Arrests") +
      theme(legend.position = "none"))



#IDEAS FOR ANALYSIS:
#Even though Black people only take up 13.4% of the population, they take up
#27.97% of the victims, showing racial inequality in terms of police shootings