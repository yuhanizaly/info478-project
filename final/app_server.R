library("shiny")
library("tidyverse")
library("plotly")
library("openintro")
library("reshape2")


server <- function(input, output){
  #Page 2
  output$tab2_graph <- renderPlotly({
    
    data <- read.csv("../shootings_wash_post.csv")
    victim_data <- read.csv("victim_race_data.csv")
    
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
          caption ="Source: US 2019 Census & Mapping Police Violence",
          fill = "Type of Proportion"))
    
  })

  
  
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