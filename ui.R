library(shiny)
library(leaflet)
library(shinyjs)

ui <- fluidPage(
  useShinyjs(),
  titlePanel("MobilitySverige"),
  sidebarLayout(
    sidebarPanel(
      width = 4,
      selectInput(
        "Country", 
        "Country:", 
        choices = c("France","Sweden")
      ),
      uiOutput("city_selector"),
      radioButtons(
        "poiType", 
        "Mobility type:", 
        choices = c("Train" = "Train", "Bus" = "Bus")
      ),
      actionButton("go", "Search", class = "btn-primary"),
      hr(),
      h4("City Informations"),
      div(
        style = "margin-top: 10px; padding: 10px; border: 1px solid #ddd; border-radius: 4px; background-color: #f9f9f9;",
        strong(textOutput("cityPopulation")),
        strong(textOutput("cityArea")),
        strong(textOutput("cityDensity"))
      ),
      h4("Mobility Informations"),
      div(
        style = "margin-top: 10px; padding: 10px; border: 1px solid #ddd; border-radius: 4px; background-color: #f9f9f9;",
        strong(textOutput("totalRecords")),
        strong(textOutput("densityStopStation")),
      )
    ),
    mainPanel(
      leafletOutput("mapPlot", height = 600)
    )
  )
)
