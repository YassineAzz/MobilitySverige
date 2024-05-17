ui <- fluidPage(
  useShinyjs(),  # Permet l'utilisation des fonctions JavaScript dans Shiny
  titlePanel("MobilitySverige"),  # Titre de l'application
  sidebarLayout(
    sidebarPanel(
      width = 4,  # Largeur du panneau latéral
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
        choices = c("Subway" = "Subway", "Bus" = "Bus", "Train" = "Train")
      ),
      actionButton("go", "Import POIs"),
      hr(),  # Ligne horizontale pour la séparation visuelle
      h4("Total Records"),
      verbatimTextOutput("totalRecords"),  # Affichage des records total
      DTOutput("poiTable")  # Table des POIs
    ),
    mainPanel(
      leafletOutput("mapPlot")  # Carte Leaflet
    )
  )
)
