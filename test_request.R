# Votre clé API - Remplacez cette valeur par votre véritable clé API
api_key <- "e3ba9041110145cc965d93c60d72838c"

# Code IATA de l'aéroport, par exemple, Arlanda (ARN)
airport_code <- "ARN"

# Direction des vols : 'A' pour les arrivées, 'D' pour les départs
direction <- "A"  # Utilisez "D" pour les départs si nécessaire

# Construire l'URL pour la requête de l'API
url <- paste0("https://api.swedavia.se/airportinfo/v2/airlines",
              "?airport=", airport_code,
              "&direction=", direction)

# Préparer les en-têtes HTTP avec votre clé API
headers <- add_headers(Authorization = paste("Bearer", api_key))

# Effectuer la requête HTTP GET
response <- GET(url, headers)

# Analyser la réponse JSON
airlines_info <- content(response, "parsed")

# Afficher les résultats
if (length(airlines_info) > 0) {
  print("Informations sur les compagnies aériennes récupérées avec succès:")
  print(airlines_info)
} else {
  print("Aucune information n'a été trouvée pour les critères donnés.")
}
