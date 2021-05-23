library(tidyverse)
library(plotly)


data <- read.csv("shootings_wash_post.csv")
victim_data <- read.csv("")

#make dataframe for proportion of race according to US census:
#https://www.census.gov/quickfacts/fact/table/US/PST045219


#unknown race was not included as unable to accurately identify
#which US Census Race cateogory victims belong to.
race_names <- c("Asian", "Black", "Hispanic", "Native American",
          "Pacific Islander", "White")
race_prop <- c(5.9, 13.4, 18.5, 1.3, 0.2, 60.1)

population_race <- data.frame(race_names, race_prop)