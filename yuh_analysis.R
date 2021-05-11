#yuhaniz pt 2

library(dplyr)
library(ggplot2)
library(plotly)

df <- read.csv("deaths_arrests.csv", stringsAsFactors = FALSE)

df_edit <- na_if(df, "") %>%
  filter(!is.na(Avg.Annual.Police.Homicide.Rate.for.Black.People)) %>%
  filter(!is.na(Avg.Annual.Police.Homicide.Rate.for.White.People)) %>%
  group_by(State)


homicide_plot <- ggplot(df_edit) +
  geom_point(mapping = aes(x = Avg.Annual.Police.Homicide.Rate.for.Black.People, 
                           y = Avg.Annual.Police.Homicide.Rate.for.White.People)) +
  geom_abline(intercept = 0, slope = 1) +
  coord_cartesian(xlim = c(0, 72), ylim = c(0, 72)) +
  labs(title = "Average Annual Police Homicide Rate between Black and White People",
       x = "Police Homicide Rate for Black People",
       y = "Police Homicide Rate for White People"
  )
                    

ggplotly(homicide_plot)

p <- plot_ly(
  df_edit,
  x = ~Avg.Annual.Police.Homicide.Rate.for.Black.People, 
  y = ~Avg.Annual.Police.Homicide.Rate.for.White.People,
  color = ~Avg.Annual.Police.Homicide.Rate, 
  size = ~Avg.Annual.Police.Homicide.Rate,
  type = "scatter",
  mode = "markers",
  text = ~paste(State)
) %>%
  layout(
    title = "Average Annual Police Homicide Rate between Black and White People",
    xaxis = list(
      title = "Police Homicide Rate for Black People"
    ),
    yaxis = list(
      title = "Police Homicide Rate for White People"
    )
  )

            
