require "google_drive"
require_relative "scrap_mairies47"
#Appel de la Gem Google drive.
#Lien avec le fichier Scrap_mairies qui contient les hash des noms et adresses mail des mairies.


def tableau_rangement
  session = GoogleDrive::Session.from_config("config.json")
  ws = session.spreadsheet_by_key("1yJjGb8uv5Y4-A4WdAKhT2lbO7WAmacYSKFPtGoj02_U").worksheets[0]
  i = 1
  rangement.each do |mairie|
    ws[i, 1] = mairie[:name]
    ws[i, 2] = mairie[:email]
	i += 1
  end
  ws.save
end
tableau_rangement
#Fonction "tableau_rangement".
#Ouverture de la session Google drive avec les clefs inscrites dans le fichier "config.json".
#Connexion avec le tableau créé sur le drive grace à la cléf.
#Vrariable i qui est égale (débute) à 1. 
#Séparation des chaque hash contenus dans le tableau "rangement". Chaque éléments s'appellent "mairie".
#Dans ligne i de la colonne 1 on stocke les valeurs "name" de chaque mairies. 
#Dans ligne i de la colonne 2 on stocke les valeurs "email" de chaque mairies.
#On dit que dès que la ligne à reçu ses valeurs, on passe à la ligne suivante.
#On ferme la boucle.
#Quand toutes les valeurs de tout les hash sont inscrites, on sauvegarde le spreadsheet.
#On ferme la fonction.
#On appelle la fonction "tableau_rangement".

