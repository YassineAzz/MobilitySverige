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
        "city", 
        "Municipality:", 
        choices = c("Stockholm", "Göteborg", "Malmö", "Uppsala", "Västerås", "Örebro", "Linköping", 
                    "Helsingborg", "Jönköping", "Norrköping", "Lund", "Umeå", "Gävle", "Borås", 
                    "Eskilstuna", "Södertälje", "Karlstad", "Täby", "Växjö", "Halmstad")
      ),
      radioButtons(
        "poiType", 
        "POI Type:", 
        choices = c("Train" = "Train", "Bus" = "Bus")
      ),
      actionButton("go", "Search", class = "btn-primary"),
      hr(),
      h4("City Information"),
      div(
        style = "margin-top: 10px; padding: 10px; border: 1px solid #ddd; border-radius: 4px; background-color: #f9f9f9;",
        strong(textOutput("cityPopulation")),
        strong(textOutput("cityArea")),
        strong(textOutput("cityDensity"))
      )
    ),
    mainPanel(
      leafletOutput("mapPlot", height = 600)
    )
  )
)
