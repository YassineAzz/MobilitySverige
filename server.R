library(shiny)
library(tmap)
library(leaflet)
library(DT) 
library(shinyjs)
library(httr)
library(jsonlite)

# Function to get coordinates and API name based on the selected city
getCityCoordinates <- function(city) {
  # Mapping from city names displayed to city names used in the API
  city_names_for_api <- c(
    "Stockholm" = "Stockholm",
    "Göteborg" = "Goeteborg",
    "Malmö" = "Malmoe",
    "Uppsala" = "Uppsala",
    "Linköping" = "Linkoeping",
    "Västerås" = "Vaesteras",
    "Örebro" = "Oerebro",
    "Helsingborg" = "Helsingborg",
    "Norrköping" = "Norrkoeping",
    "Jönköping" = "Joenkoeping",
    "Lund" = "Lund",
    "Umeå" = "Umea",
    "Gävle" = "Gaevle",
    "Borås" = "Boras",
    "Eskilstuna" = "Eskilstuna",
    "Södertälje" = "Soedertaelje",
    "Karlstad" = "Karlstad",
    "Täby" = "Taeby",
    "Växjö" = "Vaexjoe",
    "Halmstad" = "Halmstad"
  )
  
  # Coordinate mapping remains as before
  coords <- switch(city,
                   "Stockholm" = c(59.3293, 18.0686),
                   "Göteborg" = c(57.7089, 11.9746),
                   "Malmö" = c(55.6050, 13.0038),
                   "Uppsala" = c(59.8586, 17.6389),
                   "Linköping" = c(58.4109, 15.6214),
                   "Västerås" = c(59.6162, 16.5528),
                   "Örebro" = c(59.2753, 15.2134),
                   "Helsingborg" = c(56.0467, 12.6944),
                   "Norrköping" = c(58.5877, 16.1924),
                   "Jönköping" = c(57.7815, 14.1562),
                   "Lund" = c(55.7047, 13.1910),
                   "Umeå" = c(63.8258, 20.2630),
                   "Gävle" = c(60.6745, 17.1417),
                   "Borås" = c(57.7210, 12.9401),
                   "Eskilstuna" = c(59.3710, 16.5092),
                   "Södertälje" = c(59.1955, 17.6252),
                   "Karlstad" = c(59.3793, 13.5036),
                   "Täby" = c(59.4439, 18.0687),
                   "Växjö" = c(56.8777, 14.8091),
                   "Halmstad" = c(56.6745, 12.8568),
                   NULL)  # NULL if no city found
  
  list(coordinates = coords, apiName = city_names_for_api[city])
}

server <- function(input, output) {
  observeEvent(input$go, {
    shinyjs::disable('go')
    shinyjs::delay(5000, shinyjs::enable('go'))
    
    if (is.null(input$city) || is.null(input$poiType)) {
      output$mapPlot <- renderTmap({
        tmap_mode("view")
        tm_shape() + tm_basemap(server = "OpenStreetMap")
      })
      return()
    }
    
    city_data <- getCityCoordinates(input$city)
    if (is.null(city_data$coordinates)) {
      print("Coordinates not found for the specified city")
      output$mapPlot <- renderTmap({
        tmap_mode("view")
        tm_shape() + tm_basemap(server = "OpenStreetMap")
      })
      return()
    }
    
    print(input$city)
    url <- "https://gisdataapi.cetler.se/data101"
    params  <- list(
      dbName = 'OSM',
      ApiKey = "v24yasazdu.sew5BUuppB!j5Orj8fNWFEPZQCjia2ryTeIY5OHsgqrCVCt1ThNh",
      bufferType = "poly",
      dataType = "poi",
      centerPoint = paste(city_data$coordinates, collapse=","),
      radius = "5000",
      V = "1",
      key = 'public_transport',
      value = ifelse(input$poiType == "Subway", "station", ifelse(input$poiType == "Bus", "stop_position", "stop_area")),
      poly=city_data$apiName
    )
    
    response <- GET(url, query = params)
    if (status_code(response) == 200) {
      json_data <- fromJSON(content(response, "text"))
      if (!is.null(json_data) && length(json_data) > 0 && "longitude" %in% names(json_data) && "latitude" %in% names(json_data)) {
        data <- st_as_sf(json_data, coords = c("longitude", "latitude"), crs = 4326, agr = "constant")
        output$mapPlot <- renderTmap({
          tmap_mode("view")
          tm_shape(data) + tm_symbols(size = 0.1, col = "blue")
        })
      } else {
        print("No valid data to display on map.")
        output$mapPlot <- renderTmap({
          tmap_mode("view")
          tm_shape() + tm_basemap(server = "OpenStreetMap")
        })
      }
    } else {
      print(paste("Error in API response:", status_code(response)))
      output$mapPlot <- renderTmap({
        tmap_mode("view")
        tm_shape() + tm_basemap(server = "OpenStreetMap")
      })
    }
  })
}


