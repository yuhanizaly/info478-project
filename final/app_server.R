library("shiny")
library("tidyverse")
library("plotly")
library("openintro")


server <- function(input, output){
  #Page 2
  
  
  #Page 3

  output$tab3_graph <- renderPlotly({
    data_tab3 <- read.csv("shootings_wash_post_copy.csv")
    data_tab3$state <- abbr2state(data_tab3$state)
    data_tab3$body_camera <- as.character(data_tab3$body_camera)
    
    filtered_data_tab3 <- reactive({
      data_tab3 %>%
        dplyr::filter(body_camera == as.character(input$bodycam)) %>%
        dplyr::filter(race == input$race.1 | race == input$race.2) %>%
        group_by(state, race) %>%
        summarise(total = length(race)) %>%
        spread(key = race,
               value = total) %>%
        dplyr::arrange("state",
                       input$race.1, 
                       input$race.2) 
    })
    
    graph <- ggplot(data = filtered_data_tab3(), aes(fill = state)) +
      geom_point(mapping = aes_string(x = input$race.1,
                                      y = input$race.2)) +
      xlim(0, 90) +
      ylim(0, 90) +
      geom_abline(intercept = 0, slope = 1) +
      labs(title = ifelse(input$bodycam == "TRUE", "Number of People Killed by Police With a Body Camera",
                          "Number of People Killed by Police Without a Body Camera"),
           x = "Number of People Killed (Race 1)",
           y = "Number of People Killed (Race 2)") +
      theme(legend.position = "none")
    
    graph <- ggplotly(graph)
  })
}
#server <- function(input, output) {
  # creates [insert chart type]

    
  
  
  #  creates [insert chart type]

# }