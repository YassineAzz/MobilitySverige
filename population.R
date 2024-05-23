# Création d'un dataframe avec les informations
population_data <- data.frame(
  City = c("Stockholm", "Göteborg", "Malmö", "Uppsala", "Västerås", "Örebro", 
           "Linköping", "Helsingborg", "Norrköping", "Jönköping", "Lund", 
           "Umeå", "Gävle", "Borås", "Eskilstuna", "Södertälje", "Karlstad", 
           "Täby", "Växjö", "Halmstad"),
  Population = c(975551, 583056, 347949, 233839, 150000, 124207, 164616, 
                 145789, 137326, 142427, 124935, 128430, 102418, 113884, 
                 107005, 103656, 94753, 68253, 70047, 72000)
)

# Spécification du chemin complet pour enregistrer le fichier CSV
file_path <- "C:\\Users\\yassi\\Documents\\GIS map & data visualization\\Assignment final\\population_data.csv"

# Écriture du dataframe dans un fichier CSV au chemin spécifié
write.csv(population_data, file_path, row.names = FALSE)
