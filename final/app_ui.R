library("shiny")
library("tidyverse")
library("plotly")
library("reshape2")

# Intro page
page_one <- tabPanel(
  "Page 1"
)

page_two <- tabPanel(
  "Is there Racial Inequality in Victims of Police Shootings?",
  plotlyOutput("tab2_graph"),
  "In this graph, we compare the race proportions of the population with
  the race proportions of the victims killed in police shootings."
)


# page three content here
side_three <- sidebarPanel(
  selectInput(inputId = "race.1",
              label = h3("Race 1"),
              c("White" = "W",
                "Asian" = "A",
                "Black" = "B",
                "Hispanic" = "H",
                "Other" = "O",
                "Native American" = "N")
              ),
  selectInput(inputId = "race.2",
              label = h3("Race 2"),
              c("White" = "W",
                "Asian" = "A",
                "Black" = "B",
                "Hispanic" = "H",
                "Other" = "O",
                "Native American" = "N")
              ),
  selectInput(inputId = "bodycam",
                label = h3("Used a Body Camera"),
              c("Yes" = "TRUE",
                "No" = "FALSE"))
)

main_three <- mainPanel(
  plotlyOutput("tab3_graph")
)

page_three <- tabPanel(
  "When Are Police Using Their Body Cameras?",
  sidebarLayout(side_three, main_three)
)


page_four <- tabPanel(
 "Page 4"
)

# Conclusion and insights from analysis and visualizations
page_five <- tabPanel(
  "Conclusion"
)

ui <- navbarPage(
    "title here",
    page_one,
    page_two,
    page_three,
    page_four
  )
