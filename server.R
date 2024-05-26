getCityCoordinates <- function(city) {
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
    "Halmstad" = "Halmstad",
    "Marseille" = "Marseille",
    "Lyon" = "Lyon",
    "Toulouse" = "Toulouse",
    "Nice" = "Nice",
    "Nantes" = "Nantes",
    "Strasbourg" = "Strasbourg",
    "Montpellier" = "Montpellier",
    "Bordeaux" = "Bordeaux",
    "Lille" = "Lille",
    "Rennes" = "Rennes",
    "Reims" = "Reims",
    "Le Havre" = "Le Havre",
    "Saint-Étienne" = "Saint-Etienne",
    "Toulon" = "Toulon",
    "Grenoble" = "Grenoble",
    "Dijon" = "Dijon",
    "Angers" = "Angers",
    "Nîmes" = "Nimes",
    "Villeurbanne" = "Villeurbanne"
  )
  
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
                   "Marseille" = c(43.2965, 5.3698),
                   "Lyon" = c(45.7640, 4.8357),
                   "Toulouse" = c(43.6045, 1.4442),
                   "Nice" = c(43.7102, 7.2620),
                   "Nantes" = c(47.2184, -1.5536),
                   "Strasbourg" = c(48.5734, 7.7521),
                   "Montpellier" = c(43.6119, 3.8772),
                   "Bordeaux" = c(44.8378, -0.5792),
                   "Lille" = c(50.6292, 3.0573),
                   "Rennes" = c(48.1173, -1.6778),
                   "Reims" = c(49.2583, 4.0317),
                   "Le Havre" = c(49.4944, 0.1079),
                   "Saint-Étienne" = c(45.4397, 4.3872),
                   "Toulon" = c(43.1242, 5.9280),
                   "Grenoble" = c(45.1885, 5.7245),
                   "Dijon" = c(47.3220, 5.0415),
                   "Angers" = c(47.4784, -0.5632),
                   "Nîmes" = c(43.8367, 4.3601),
                   "Villeurbanne" = c(45.7719, 4.8902),
                   NULL)
  
  list(coordinates = coords, apiName = city_names_for_api[city])
}

# Load population data (CSV file added manually info from Wikiu)
population_data <- read.csv("C:/Users/yassi/Documents/GIS map & data visualization/Assignment final/biggest_city_data.csv")

server <- function(input, output, session) {
  # Update city selectInput (Dynamic) to improve app
  observeEvent(input$Country, {
    if (input$Country == "France") {
      updateSelectInput(session, "city", "Municipality in France:", 
                        choices = c("Marseille", "Lyon", "Toulouse", "Nice", "Nantes", 
                                    "Strasbourg", "Montpellier", "Bordeaux", "Lille", "Rennes", 
                                    "Reims", "Le Havre", "Saint-Étienne", "Toulon", "Grenoble", 
                                    "Dijon", "Angers", "Nîmes", "Villeurbanne"))
    } else if (input$Country == "Sweden") {
      updateSelectInput(session, "city", "Municipality in Sweden:", 
                        choices = c("Stockholm", "Göteborg", "Malmö", "Uppsala", "Västerås", "Örebro", 
                                    "Linköping", "Helsingborg", "Jönköping", "Norrköping", "Lund", 
                                    "Umeå", "Gävle", "Borås", "Eskilstuna", "Södertälje", "Karlstad", 
                                    "Täby", "Växjö", "Halmstad"))
    }
  })
  
  output$city_selector <- renderUI({
    selectInput("city", "Select Municipality:", choices = NULL)
  })
  
  #Info from the csv file (Add info ?)
  observeEvent(input$go, {
    if (!is.null(input$city)) {
      population <- population_data$Population[population_data$City == input$city]
      area <- population_data$Area[population_data$City == input$city]
      density <- population_data$Density[population_data$City == input$city]
      
      output$cityPopulation <- renderText({
        paste("Population:", ifelse(length(population) > 0, population, "N/A"))
      })
      output$cityArea <- renderText({
        paste("Area:", ifelse(length(area) > 0, area, "N/A"), "km²")
      })
      output$cityDensity <- renderText({
        paste("Density:", ifelse(length(density) > 0, round(density, 1), "N/A"), "people/km²")
      })
    }
    shinyjs::disable('go')
    shinyjs::delay(5000, shinyjs::enable('go'))
    
    if (is.null(input$city) || is.null(input$poiType)) {
      output$mapPlot <- renderTmap({
        tmap_mode("view")
        tm_shape() + tm_basemap(server = "OpenStreetMap")
      })
      return()
    }
    
    #use the fonction get coord 
    city_data <- getCityCoordinates(input$city)
    if (is.null(city_data$coordinates)) {
      output$mapPlot <- renderTmap({
        tmap_mode("view")
        tm_shape() + tm_basemap(server = "OpenStreetMap")
      })
      return()
    }
    
    #parameters pf request
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
      value = ifelse(input$poiType == "Train", "station", ifelse(input$poiType == "Bus", "stop_position", "stop_area")),
      poly=city_data$apiName
    )
    records <- reactiveVal()
    observeEvent(json_data, {
      records(length(json_data$poiName)) 
    })
    
    output$totalRecords <- renderText({
      req(records()) 
      paste("Total station:", records())
    })
    
    output$densityStopStation <- renderText({
      req(records()) 
      density <- records() / 78 #to convert from total into /km² (radius = "5000" if edit edit here too)
      paste("Density station:", round(density, 1), "station(s)/km²")
    })
    
    #To add information to the website
    output$poiTable <- renderDataTable({
      data <- json_data[, c("value", "poiName", "within_500m")]
      data$value[data$value == "stop_position"] <- "Bus stop"
      data$value[data$value == "station"] <- "Train stop"
      data <- data %>% rename('Stop type' = value, 'Station name' = poiName, 'Nearby stations' = within_500m)
      datatable(data, options = list(pageLength = 5, searching = FALSE, paging = TRUE)) 
    })

    response <- GET(url, query = params)
    if (status_code(response) == 200) {
      json_data <- fromJSON(content(response, "text"))
      print(json_data)
      json_data <- fromJSON(content(response, "text"))
      bus_stops <- st_as_sf(json_data, coords = c("longitude", "latitude"), crs = 4326)
      distances <- st_distance(bus_stops)
      # Add column to data (find around 500m)
      #Maybe change method take some time for big cities
      within_500m <- apply(distances, 1, function(row) if (any(row < 500 & row != 0)) "Yes" else "No")
      json_data$within_500m <- within_500m
      
      if (!is.null(json_data) && length(json_data) > 0 && "longitude" %in% names(json_data) && "latitude" %in% names(json_data)) {
        data <- st_as_sf(json_data, coords = c("longitude", "latitude"), crs = 4326, agr = "constant")
        output$mapPlot <- renderTmap({
          tmap_mode("view")
          tm_shape(data) + tm_symbols(size = 0.0001, col = 'black')+ tm_basemap(server = "OpenStreetMap")
        })
      } else {
        output$mapPlot <- renderTmap({
          tmap_mode("view")
          tm_shape() + tm_basemap(server = "OpenStreetMap")
        })
      }
    } else {
      output$mapPlot <- renderTmap({
        tmap_mode("view")
        tm_shape() + tm_basemap(server = "OpenStreetMap")
      })
    }
  })
}
