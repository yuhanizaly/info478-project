library("shiny")
library("tidyverse")
library("plotly")
library("reshape2")

# Intro page
page_one <- tabPanel(
  "Introduction",
  tags$body(
    mainPanel(
      h1("Police Violence in the US"),
      h2("Trigger Warning:"),
      p("The following content may contain triggering and/or sensitive material.
      The website discusses topics of racism, guns, and violence.
        Audience discretion is advised."),
      img(src = "police-brutality.jpeg", width = "750x", height = "450px"),
      h2("Purpose"),
      p("The purpose of our research study is to investigate the racial
        inequalities and inequities  around police violence in the United
        States. We will observe the demographics of various races impacted by
        police violence, specifically, victims who have been shot. We seek to
        see the differences and injustice in police violence. We hope to raise
        awareness about the number of people who have been victims of police
        brutality and propose a plan of action."),
      h2("Target Audience"),
      p("Our target audience is the general public who are interested in
        learning about the data around police violence in the US. Given our
        current state in the US and the #BlackLivesMatter movement, we think our
        research will benefit those who are looking for quantitative data around
        police brutality. People will learn about the number of people who were
        killed by police, the states with the most police violence, and the
        demographics. Using this information, our data allows people to
        critically think about police and injustices in the US."),
      h2("Research Questions"),
      tags$ol(
        tags$li(
          "How are races disproportionately affected by police gun
                violence?",
          tags$li("How does usage of body cameras affect the number of violence
                occurrences?"),
        )
      ),
      h2("Dataset"),
      p(
        "The", a(
          href = "https://www.kaggle.com/jpmiller/police-violence-in-the-us",
          "dataset"
        ),
        "'Police Violence and Racial Equity' was accessed on
          Kaggle. The data was created and posted by John Miller, who is a
          senior data analyst at H2O.ai. However the information on the dataset
          is pulled from several different sources including the", a(
          href = "https://mappingpoliceviolence.org/aboutthedata",
          "Mapping Police Violence database"
        ),
        "and the", a(
          href = "https://fatalencounters.org",
          "Encounters database."
        )
      ),
    )
  )
)

# page 2 - Race inequality among victims
page_two <- tabPanel(
  "Race Inequality Among Victims",
  titlePanel("How are races disproportionately affected by police
             gun violence? "),
  plotlyOutput("tab2_graph"),
  mainPanel(
    h2("How to read the graph:"),
    p("The Y-axis displays the proportion of the population in the U.S, and the
    X-axis displays race. This graph displays two bars per race, the orange
    exhibiting the proportion of that particular racial group in the U.S, in
    comparison to the blue bar which exhibits the proportion of victims in that
    racial group also in the U.S. This side by side comparison allows readers
    to view the proportion of victims in a given race compared to the proportion
    of the population in that race group. Any of the races where the victim
    proportion (blue) exceeds the population proportion (orange) indicates
    disproportionate measures of police violence. To view the exact values of
    percentages, users may hover over the bars."),
    h2("Observation & Analysis"),
    p("The data shows that the race with the largest proportion of the U.S
    population is White. The police violence victim proportion for the
    White population indicates that as population proportion increases, so does
    violence proportion. Similarly, the Asian population showed fewer victim
    proportions.  However, the rest of the races analyzed in this dataset do not
    show the same trends. Black, Hispanic, Native American, and Pacific Islander
    populations all reveal victim proportions that surpass population
    proportions."),
    p("The two other races that make up larger percentages of the U.S population
    are Hispanic and Black populations. However Black people suffer the highest
    deaths within the Black racial population. Even though Black people only
    make up 13.4% of the U.S population, they suffer 27.9% of police violence.
    Similarly, the proportion of deaths of Hispanic victims is 19.2%, which is
    higher than the proportion of Hispanics in the general population (18.5%),
    although it is less disproportionate than the statistics for Black people.
    The difference in victim proportions between Black and Hispanic groups
    suggest that police violence is most targeted towards Black populations.
    Similarly, while Pacific Islander and Native American groups make up the
    smallest percentage of the U.S population, they also still suffer the
    consequences of racial police violence, with higher victim proportions than
    their population proportions. These numbers allude to police shootings being
    driven by racial prejudices. While Asian populations may be exempt from this
    conclusion in this data set, all other racial group statistics point to
    racial inequalities. Our next step will be to further explore the Asian
    population as an outlier and make further conclusions.")
  )
)


# page 3 widgets
side_three <- sidebarPanel(
  selectInput(
    inputId = "race.1",
    label = h3("Race 1"),
    c(
      "White" = "W",
      "Asian" = "A",
      "Black" = "B",
      "Hispanic" = "H",
      "Other" = "O",
      "Native American" = "N"
    )
  ),
  selectInput(
    inputId = "race.2",
    label = h3("Race 2"),
    c(
      "White" = "W",
      "Asian" = "A",
      "Black" = "B",
      "Hispanic" = "H",
      "Other" = "O",
      "Native American" = "N"
    )
  ),
  selectInput(
    inputId = "bodycam",
    label = h3("Used a Body Camera"),
    c(
      "Yes" = "TRUE",
      "No" = "FALSE"
    )
  )
)

main_three <- mainPanel(
  plotlyOutput("tab3_graph")
)

# page 3 - Usage of body camera
page_three <- tabPanel(
  "Usage of Body Camera",
  titlePanel("How does usage of body cameras affect the number of violence
             occurrences?"),
  sidebarLayout(side_three, main_three),
  mainPanel(
    h2("How to read the graph:"),
    p("The x-axis represents the number of fatalities from the first race chosen
      by the user, and the y-axis represents the second race. Finally, a user
      selects whether police’s body cameras were on or off during the fatality.
      This changes the data being displayed to filter for that. If the user
      drags their mouse over each dot, it shows the raw number of each race
      being compared that were killed, and the state in which it happened.
      This way, users can see trends geographically and across race. It is also
      important to note that these are", tags$b("raw values that are not
      proportional to
      the percentage of each race making up the population.")),
    h2("Observation & Analysis"),
    p("This graph allows users to quickly compare which races suffer more
      consequences of police brutality. Comparing the number of White people by
      the number of Black people killed by guns, it is evident that the number
      of White people killed is higher. Still, the number of Black deaths don’t
      fall far behind the number of White deaths. However, it is important to
      note that the number of White people in the U.S is significantly higher
      than the number of Black people, which points to a disproportionate burden
      of deaths among Black people. Comparatively, despite having a smaller
      Asian population in the U.S, the number of Asian deaths are significantly
      lower than White deaths. This finding suggests racial violence highly
      targeted towards Black racial groups. One limitation to this finding is
      that the graph uses raw numbers to display results."),
    p("Another observation from this graph is that across races police tend to
    have their body cameras off during fatal shootings. In any racial group
    comparison, changing the filter to display the number of fatal shootings
    that used a body camera will significantly drop the number of states and
    people killed. Moreover, using a body camera stabilizes the number of
    fatalities between races. When police have their cameras on, the number of
    fatalities are more similar across all races. It is important to consider
    that the data was collected from the Washington post for fatal police
    shootings between 2015-2020. The information may not be credible and may
    have changed throughout the years."),
  )
)


# Conclusion and insights from analysis and visualizations
page_four <- tabPanel(
  "Conclusion",
  mainPanel(
    h2("Politics"),
    p("placeholder"),
    h2("Notable Outliers"),
    p("placeholder"),
    h2("Call to Action"),
    p("palceholder"),
  )
)

# About us page
page_five <- tabPanel(
  "About",
  mainPanel(
    h2("INFO 478: Population Health Informatics (Sring 2021)"),
    p("Names: Yuhaniz Aly, Morgan Bryson, Dainese Chandra, Karen Garcia"),
    p("Professor: Dr. Katrtin Burkart"),
    p("TA: Jamie Costales")
  )
)


ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    "Police Violence",
    page_one,
    page_two,
    page_three,
    page_four,
    page_five
  )
)
