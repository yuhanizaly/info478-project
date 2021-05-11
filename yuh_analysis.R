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
                           color=State)) +
  theme(legend.position = "none") +
  geom_abline(intercept = 0, slope = 1) +
  coord_cartesian(xlim = c(0, 30), ylim = c(0, 30)) +
  labs(title = "Average Annual Police Homicide Rate between Black and White
        People",
       x = "Police Homicide Rate for Black People",
       y = "Police Homicide Rate for White People"
  )
  

#Interactive scatter plot
homicide_plot_interactive <- ggplotly(homicide_plot)