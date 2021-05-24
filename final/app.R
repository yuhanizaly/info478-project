library("shiny")
library("tidyverse")
library("plotly")
library("openintro")

source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)
