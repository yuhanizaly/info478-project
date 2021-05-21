library("shiny")
library("ggplot2")
library("dplyr")
library("tidyr")
library("plotly")

# insert dataframes


# Intro page
page_one <- tabPanel(

)

page_two <-
  tabPanel(

)

# page three content here
page_three <- tabPanel(
  
)


page_four <- tabPanel(
 
)

# Conclusion and insights from analysis and visualizations
page_five <- tabPanel(
  "Conclusion",
  
)

ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    "title here",
    page_one,
    page_two,
    page_three,
    page_four
  )
)
