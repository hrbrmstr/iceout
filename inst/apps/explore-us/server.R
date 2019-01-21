library(shiny)
library(stats)
library(iceout)
library(countrycode)
library(hrbrthemes)
library(dplyr)
library(ggplot2)

data("nsidc_iceout")

filter(nsidc_iceout, country == "United States") %>%
    filter(!is.na(latitude) & !is.na(longitude)) %>%
    filter(!is.na(iceout_date)) -> us

st_trans <- setNames(state.name, state.abb)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    observe({
        updateSelectInput(
            session = session,
            inputId = "state",
            choices = sort(unique(us$state)),
            selected = "ME"
        )
    })

    observe({

        if ((length(input$state) == 0) || input$state == "") return()

        filter(us, state == input$state) %>%
            select(lakename) %>%
            arrange(lakename) %>%
            pull(lakename) -> state_lakes

        updateSelectInput(
            session = session,
            inputId = "lake",
            choices = state_lakes,
            selected = state_lakes[1]
        )

    })


    output$iceout_plot <- renderPlot({

        if ((length(input$state) == 0) || (input$state == "")) return()
        if ((length(input$lake) == 0) || (input$lake == "")) return()

        mutate(us, iceout_date = as.Date(
            format(iceout_date, "2020-%m-%d")
        )) %>%
            { us_lims <<- range(.$iceout_date, na.rm=TRUE); . } %>%
            filter(
                state == input$state,
                lakename == input$lake
            ) -> st

        if (nrow(st) == 0) return()

        ggplot(st, aes(iceoff_year, iceout_date)) +
            geom_point(color = ft_cols$slate, alpha=(1/2)) +
            geom_smooth(method = "loess", color = ft_cols$blue, size=1) +
            scale_y_date(date_labels = "%b-%d", limits = if (input$relative) range(st$iceout_date, na.rm=TRUE) else us_lims) +
            labs(
               x = NULL, y = "Ice-out Month/Day",
               title = sprintf("Ice-out History for %s, %s ", st$lakename[[1]], st_trans[st$state[[1]]]),
               caption = "Source: NSIDC <https://nsidc.org/data/G01377>"
            ) +
            theme_ft_rc(grid="XY")

    })

    output$state_map <- renderLeaflet({

        if ((length(input$state) == 0) || (input$state == "")) {
            return()
        }

        if ((length(input$lake) == 0) || (input$lake == "")) {
            return()
        }

        filter(us, state == input$state, lakename == input$lake) %>%
            distinct(longitude, latitude) -> lk

        if (nrow(lk) != 1) return()

        leaflet(lk) %>%
            addTiles() %>%
            setView(lk$longitude[1], lk$latitude[1], 10)

    })


})
