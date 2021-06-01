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
      h2("Trigger Warning"),
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
  titlePanel("How are Races Disproportionately affected by Police
             Gun Violence? "),
  plotlyOutput("tab2_graph"),
  mainPanel(
    h2("How to Read the Graph"),
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
    h2("Numbers Used"),
    p(
      "The dataset used only displayed the number of victims shot by police.
    Victim proportions were calculated by grouping the number of victims in
      each racial group and dividing by the amount of total victims in the data.
      Population proportions were gathered from the,", a(
        href = "https://www.census.gov/quickfacts/fact/table/US/PST045219",
        "U.S census"
      ),
      "where we calculated the racial makeup of the U.S population."
    ),
    h2("Observations & Analysis"),
    p("The data shows that people identifying as White compose most of the U.S.
      population. This graph shows that in the White population, the number of
      victims is proportional to the size of the overall population. This trend
      was also demonstrated among people who identify as Asian. However, the
      rest of the races analyzed in this dataset do not show the same trends.
      Black, Hispanic, Native American, and Pacific Islander populations all
      reveal victim proportions that surpass population proportions."),
    p("The two other races that make up larger percentages of the U.S population
      are Hispanic and Black populations. However Black people suffer the
      highest deaths within these racial populations. Even though Black people
      only make up 13.4% of the U.S population, they suffer 27.9% of police
      violence. Similarly, the proportion of deaths of Hispanic victims is
      19.2%, which is higher than the proportion of Hispanics in the general
      population (18.5%), although it is less disproportionate than the
      statistics for Black people. The difference in victim proportions between
      Black and Hispanic groups suggest that police violence is most targeted
      towards Black populations. Similarly, while Pacific Islander and Native
      American groups make up the smallest percentage of the U.S population,
      they also still suffer the consequences of racial police violence, with
      higher victim proportions than their population proportions. These numbers
      allude to police shootings being driven by racial prejudices. While Asian
      populations may be exempt from this conclusion in this data set, all other
      racial group statistics point to racial inequalities. Next steps would be
      to further explore the reasons for decreased occurrences of violence
      towards Asian populations.")
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
  titlePanel("How does Usage of Body Cameras affect the Number of Violence
             Occurrences?"),
  sidebarLayout(side_three, main_three),
  mainPanel(
    h2("How to Read the Graph"),
    p("The x-axis represents the number of fatalities from the first race chosen
    by the user, and the y-axis represents the second race. Next, users may
    select whether police’s body cameras were on or off during the fatality.
    This changes the data being displayed to filter for that. The diagonal line
    across the chart is used to distinguish between each half of the graph,
    where anything above the line shows that the number of people killed by
    police with a body camera in race 2 is higher than race 1. To see raw number
    comparisons of each race killed in each state, the user may drag the mouse
    over each dot. This way, users can see trends geographically and across
    race. It is also important to note that these are", tags$b("raw values
    that are not proportional to the percentage of each race making up the
    population.")),
    h2("Observations & Analysis"),
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
      shootings between 2015-2020. While the dataset is comprehensive, we would
      still like to acknowledge it may have missing values that don’t tell a
      full story due to deficient police records."),
  )
)


# Conclusion and insights from analysis and visualizations
page_four <- tabPanel(
  "Conclusion",
  mainPanel(
    h2("Conclusion"),
    p("Findings in our graphs raised questions about the attributes of states in
    the data. Our second graph observing the number of people killed by police
    with or without a body camera showed that when body cameras were turned on,
    the number of deaths across all races significantly dropped. Because this
    pattern was observed across all races, we wondered if the use of body
    cameras has anything to do with the policies and laws of each state. With
    this in mind, we’d like to further investigate how each state’s political
    standing affects policy and laws."),
    p("Another observation was that Asian minorities were outliers in the
      dataset when compared to their minority counterparts. Asian racial group
      members make up only about 5.9% of the population, and their victim
      population proportion was lower at 1.7%. However, all other minority
      groups were shot at higher proportions than their population proportions.
      While Asian populations may not show to suffer the consequences of racial
      prejudices in this dataset, we’d like to acknowledge that the data was
      collected by the Washington Post and missing values may not tell a full
      story. We would like to further investigate the reasons behind the lower
      proportions of violence towards Asian population. With this being said,
      the frequency of deaths in each race was also dependent on the
      demographics of the population. For example, when comparing Asian people
      to White people killed without a body camera, the one state who had a
      higher number of Asian people killed was Hawaii. However, this is
      understandable once we know Hawaii has a higher number of Asian people."),
    p(
      "Our graphs have highlighted that communities of color are
      disproportionately affected by police brutality, where victim proportions
      exceeded population proportions. More specifically, the most affected
      racial group were Black people, whose percentage of victims were higher
      than the population despite making up a smaller amount of the Black U.S
      population. With these findings coming from our data, we’d like our
      audience to use this website as a starting place to further educate
      themselves on racial injustices and police brutality. Additionally, we’d
      like to stand in solidarity with the", a(
        href = "https://blacklivesmatter.com/about",
        "BLM"
      ),
      "movement which aims to combat
      acts of violence, create space for Black innovation, and center Black joy.
      Moreso, we’d also like to use our findings to advocate for policy to
      mandate police officers to maintain their body cameras on-duty.
      While this may be a big step for different states, the information
      provided is a tool that can be used to push for policy change and drive
      action that can be life-saving for communities."
    ),
  )
)

# About us page
page_five <- tabPanel(
  "About",
  mainPanel(
    h2("INFO 478: Population Health Informatics (Spring 2021)"),
    p(tags$b("Names:"), "Yuhaniz Aly, Morgan Bryson, Dainese Chandra, Karen Garcia"),
    p(tags$b("Professor:"), "Dr. Katrtin Burkart"),
    p(tags$b("TA:"), "Jamie Costales"),
    h2("Karen Garcia"),
    tags$ul(
      tags$li(tags$b("Major:"), "Public Health - Global Health"),
      tags$li(tags$b("Minor:"), "Informatics"),
      tags$li(tags$b("Year:"), "Graduating Senior"),
      tags$li(tags$b("Interest:"), "Police violence is a public health
              crisis resulting in unnecessary death and injury. As a public
              health advocate, bringing awareness about the disproportionate
              number of deaths communities of color face will enable me to raise
              awareness and together aim for change."),
    ),
    h2("Dainese Chandra"),
    tags$ul(
      tags$li(tags$b("Major:"), "Economics"),
      tags$li(tags$b("Year:"), "Graduating Senior"),
      tags$li(tags$b("Interest:"), "This topic interested me because as members
                of society, we do have a responsibility of educating ourselves
                about social issues, especially as these inequalities shape our
                entire lives. Recognizing our privilege and issues of the
                marginalized community is a step towards making society more
                inclusive and equal for all.")
    ),
    
    h2("Morgan Bryson"),
    tags$ul(
      tags$li(tags$b("Major:"), "Psychology"),
      tags$li(tags$b("Minor:"), "Education, Learning, and Societies"),
      tags$li(tags$b("Year:"), "Graduating Senior"),
      tags$li(tags$b("Interest:"), "This topic interested me because I feel that
            recognizing our stigmas and biases is an extremely important part of
            creating a more equitable society. I am also passionate about policy
            changes that provide justice and equality for marginalized groups of
            people.")
    ),
  
      h2("Yuhaniz Aly"),
      tags$ul(
        tags$li(tags$b("Major:"), "Public Health - Global Health"),
        tags$li(tags$b("Minor:"), "Informatics & Diversity"),
        tags$li(tags$b("Year:"), "Junior"),
        tags$li(tags$b("Interest:"), "This topic interested me because I stand
            with the #BLM movement and as an ally, I was motivated to help
            people understand the statistics and disparities between racial
            groups through the visual graphs."),
    )
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
