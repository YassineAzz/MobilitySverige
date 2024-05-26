ui <- fluidPage(
  useShinyjs(),
  tags$head(
    tags$link(rel = "icon", type = "image/x-icon", href = "favicon.png") #icon tab maybe change ????
  ),
  titlePanel("MobilityCompare"),
  sidebarLayout(
    sidebarPanel(
      width = 4,
      img(src = "logo.png", height = "100px", style = "display: block; margin: 0 auto;"), # logo okok
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
      h4("City Information"),
      div(
        style = "margin-top: 10px; padding: 10px; border: 1px solid #ddd; border-radius: 4px; background-color: #f9f9f9;",
        strong(textOutput("cityPopulation")),
        strong(textOutput("cityArea")),
        strong(textOutput("cityDensity"))
      ),
      h4("Mobility Information"),
      div(
        style = "margin-top: 10px; padding: 10px; border: 1px solid #ddd; border-radius: 4px; background-color: #f9f9f9;",
        strong(textOutput("totalRecords")),
        strong(textOutput("densityStopStation")),
      ),
      hr(),
      div(DTOutput("poiTable"))
      ),
    mainPanel(
      leafletOutput("mapPlot", height = 600)
    )
  )
)
