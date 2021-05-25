library("shiny")
library("tidyverse")
library("plotly")
library("openintro")


server <- function(input, output){
  #Page 2
  
  
  #Page 3

  output$tab3_graph <- renderPlot({
    data_tab3 <- read.csv("shootings_wash_post_copy.csv")
    data_tab3$state <- abbr2state(data_tab3$state)
    
    filtered_data_tab3 <- reactive({
      data_tab3 %>%
        dplyr::filter(ifelse(input$bodycam == "Yes", T, F)) %>%
        dplyr::filter(race %in% c(input$race.1, input$race.2)) %>%
        dplyr::filter(race != is.na(race)) %>%
        group_by(state, race) %>%
        summarise(total = length(race)) %>%
        spread(key = race,
               value = total)
    })
    
    graph <- ggplot(data = filtered_data_tab3()) +
      geom_point(mapping = aes_string(x = as.numeric(names(filtered_data_tab3())[2]),
                                      y = as.numeric(names(filtered_data_tab3())[3]))) +
      xlim(0, 100) +
      ylim(0, 100) +
      geom_abline(intercept = 0, slope = 1) +
      labs(title = "Number of White and Black People Killed by Police Without a Body Camera",
           x = "Number of Black People Killed",
           y = "Number of White People Killed")
    
    graph
  })
}
#server <- function(input, output) {
  # creates [insert chart type]

    
  
  
  #  creates [insert chart type]

# }