# ui.R

shinyUI(fluidPage(
        titlePanel("Coursera Developing Data Project - Simple Shiny App"),
        sidebarLayout(
                sidebarPanel(
                        h2("Home or Away"),
                        p("Select if you would like to see the average for Home or Away games:"),
                        
                radioButtons("radio", label = h3("Options"),
                             choices = list("Home Games" = "Home Games", "Away Games" = "Away Games"))
                ),
                mainPanel(
                        h1("Explore the St. Louis Cardinals Batting Average"),
                        h4("This app displays batting statistics for the St. Louis Cardinals, a pro baseball team"),
                        h4("Batting Average is calculated by dividing the number of hits by the number of at bats"),
                        textOutput("text1"),
                        textOutput("text2"),
                        plotOutput('plot1'),
                        h4("Disclamer"),
                        p("The information used here was obtained free of
                           charge from and is copyrighted by Retrosheet."),
                        p("Interested parties may contact Retrosheet at www.retrosheet.org.")
                          )
        )
))