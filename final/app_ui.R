library("shiny")
library("tidyverse")
library("plotly")


# Intro page
page_one <- tabPanel(
  "Page 1"
)

page_two <-
  tabPanel(
    "Page 2"
)

# page three content here
side_three <- sidebarPanel(
  selectInput(inputId = "race.1",
              label = h3("First Race of Comparison"),
              c("White" = "W",
                "Asian" = "A",
                "Black" = "B",
                "Hispanic" = "H",
                "Other" = "O",
                "Native American" = "N")
              ),
  selectInput(inputId = "race.2",
              label = h3("Second Race of Comparison"),
              c("White" = "W",
                "Asian" = "A",
                "Black" = "B",
                "Hispanic" = "H",
                "Other" = "O",
                "Native American" = "N")
              ),
  selectInput(inputId = "bodycam",
                label = "Used a Body Camera",
              c("Yes", "No"))
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
