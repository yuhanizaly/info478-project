library("shiny")
library("tidyverse")
library("plotly")
library("openintro")


server <- function(input, output){
  #Page 2
  
  
  #Page 3
  output$tab3_graph <- renderPlotly({
    
    data <- read.csv("shootings_wash_post_copy.csv")
    
    filtered_data <- dplyr::filter(data, ifelse(input$bodycam == "Yes", T, F))
    filtered_data <- dplyr::filter(filtered_data, race %in% c(input$race.1, input$race.2)) %>%
      summarise(total = length(race)) %>%
      spread(key = race,
             value = total)
    filtered_data$state <- abbr2state(filtered_data$state)
  
    graph <- ggplot(data = filtered_data) +
      geom_point(mapping = aes(x = filtered_data[1], y = filtered_data[2], fill = state),
                 size = 1.75) +
      xlim(NA, 90) +
      ylim(NA, 90) +
      geom_abline(intercept = 0, slope = 1) +
      labs(title = "Number of White and Black People Killed by Police Without a Body Camera",
         x = "Number of Black People Killed",
         y = "Number of White People Killed") +
      theme(legend.position = "none")
    
    graph <- ggplotly(graph)
    
    graph
  })
    
}
#server <- function(input, output) {
  # creates [insert chart type]

    
  
  
  #  creates [insert chart type]

# }