library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(
    fluidPage(

        # Application title
        titlePanel("Ice-out U.S. Explorer"),

        # Sidebar with a slider input for number of bins
        sidebarLayout(
            sidebarPanel(
                wellPanel(
                    HTML("<p>The U.S. National Snow and Ice Data Center <a href='http://nsidc.org/data/G01377.html'>maintains</a> a Global Lake and River Ice Phenology (seasonal phenomenon) Database consisting of freeze and thaw/breakup dates as well as other descriptive ice cover data for 865 lakes and rivers in the Northern Hemisphere. Of the 542 water bodies that have records longer than 19 years, 370 of them are in North America and 172 are in Eurasia. 249 lakes and rivers have records longer than 50 years, and 66 have records longer than 100 years. A few water bodies have data available prior to 1845. This database, with water bodies distributed around the Northern Hemisphere, allows for the analysis of broad spatial patterns as well as long-term temporal patterns.</p>"),
                    p("Choose a U.S. state and lake to see historical ice-out data and trends.")
                ),
                selectInput(
                    inputId = "state",
                    label = "State:",
                    choices = ""
                ),
                selectInput(
                    inputId = "lake",
                    label = "Lake:",
                    choices = ""
                ),
                checkboxInput(
                    inputId = "relative",
                    label = "Y-axis relative to lake?",
                    value = TRUE
                )

            ),

            # Show a plot of the generated distribution
            mainPanel(
                fluidRow(
                    column(8, leafletOutput("state_map", height=200)),
                    style="padding-bottom:30px"
                ),
                fluidRow(column(8, plotOutput("iceout_plot")))
            )
        )

    )
)
