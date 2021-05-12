#Relationship between variables
#Comparing the average annual police homicide rate between Black and
#white people

#Load libraries
library(dplyr)
library(ggplot2)
library(plotly)

#Load dataset
df <- read.csv("deaths_arrests.csv", stringsAsFactors = FALSE)

#Remove blank and n/a values and group by states
df_edit <- na_if(df, "") %>%
  filter(!is.na(Avg.Annual.Police.Homicide.Rate.for.Black.People)) %>%
  filter(!is.na(Avg.Annual.Police.Homicide.Rate.for.White.People)) %>%
  group_by(State) %>%
  summarize(rate_black = mean(Avg.Annual.Police.Homicide.Rate.for.Black.People),
            rate_white = mean(Avg.Annual.Police.Homicide.Rate.for.White.People))
          
#Scatter plot
homicide_plot <- ggplot(df_edit) +
  geom_point(mapping = aes(x = rate_black,
                           y = rate_white,
                           color = State)) +
  theme(legend.position = "none") +
  geom_abline(intercept = 0, slope = 1) +
  coord_cartesian(xlim = c(0, 30), ylim = c(0, 30)) +
  labs(title = "Average Annual Police Homicide Rate between Black and White
        People",
       x = "Police Homicide Rate for Black People",
       y = "Police Homicide Rate for White People",
       caption = "Source: Mapping Police Violence"
  )
  

#Interactive scatter plot
homicide_plot_interactive <- ggplotly(homicide_plot)

#Analysis
#This scatter plot shows that the average annual police homicide rate between
#Black and White people are not proportional. All the points, or states, under
#the line means that the average annual police homicide rate is greater among
#Black people than White people. The points above the line means that police
#homicide rate is greater among White people than Black people. The graph shows
#that three states, Hawaii, Kansas, and Alabama, have higher rates of police
#homicide among White people than Black people. However, the majority of states
#have much more incidents of higher rates of police homicide for Black people,
#as well as a rate of a higher degree.
