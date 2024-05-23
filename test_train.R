library(httr)

# URL de l'API pour obtenir les informations sur toutes les stations
url <- "http://api.tagtider.net/v1/stations.xml"

# Authentification de base avec nom d'utilisateur et mot de passe
auth <- authenticate("tagtimes", "codemocracy", type = "basic")

# Envoyer la requête
response <- GET(url, auth)

# Vérifier le statut de la réponse
if (status_code(response) == 200) {
  # Extraire le contenu de la réponse (en format XML dans ce cas)
  content <- content(response, "text", encoding = "UTF-8")
  print(content)
} else {
  print(paste("Erreur dans la requête:", status_code(response)))
}

