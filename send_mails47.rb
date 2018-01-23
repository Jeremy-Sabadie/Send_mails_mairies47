require "google_drive"
require 'json'
require 'gmail'

#Adresse du spreadsheet: https://docs.google.com/spreadsheets/d/1yJjGb8uv5Y4-A4WdAKhT2lbO7WAmacYSKFPtGoj02_U/edit#gid=0
session = GoogleDrive::Session.from_config("config.json")#Placer votre fichier config.json dans le même dossier que le programme.
#On se connecte au Google drive grace aux clefs contenues dans le fichier "config.json".

@ws = session.spreadsheet_by_key("1yJjGb8uv5Y4-A4WdAKhT2lbO7WAmacYSKFPtGoj02_U").worksheets[0]
#On se connecte sur la feuille contenant les données des mairies.
@gmail = Gmail.connect("ADRESSE.MAIL@MAIL.COM", "MOTDEPASSE")#Ici placez votre mail et mot de passe.
#Connexion au compte gmail de la boite d'envoi.

def send_email_to_line(array)
  townhall_name= array[0]
  townhall_email = array[1]
  if townhall_name
    @gmail.deliver do
      to townhall_email
      subject "The hacking project!"
      text_part do
        body
      end
      html_part do
        content_type 'text/html; charset=UTF-8'
        body get_the_email_html(townhall_name)
      end
    end
    p "mail bien envoyé à #{townhall_name}"
  end
end
#On créé la fonction "send_email_to_line" qui prend comme paramètre "array".
#On créé la variable "noms_mairies" qui correspnd à la première colonne du tableau.
#On créé la variable "mails_maires" qui correspnd à la deuxième colonne du tableau.
#On dit qui si il y a une valeur dans la variable "noms_mairies" alors on envoie un mail qui a pour objet: "Connaissez vous The Hacking Project?".
#Pour le corp du mail, on se redirige vers la fonction "get_the_email_html" qui contient un html.
#On ferme les boucles.
#On lui demande de nous afficher un message avec le nom de la mairie, lorsque le mail est envoyé.

def get_the_email_html(townhall_name, prenom= "Jérémy")
  "<p style='padding:50px; text-align:justify' >Bonjour,<br/><br/>Je m'appelle #{prenom}, je suis élève à une formation de programmation web gratuite, ouverte à tous, sans restriction géographique, ni restriction de niveau. La formation s'appelle <strong><a style='text-decoration:none' href='http://thehackingproject.org'/ >The Hacking Project</a></strong>. Nous apprenons l'informatique via la méthode du peer-learning : nous faisons des projets concrets qui nous sont assignés tous les jours, sur lesquel nous planchons en petites équipes autonomes. Le projet du jour est d'envoyer des emails à nos élus locaux pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation gratuite.<br/><br/>Nous vous contactons pour vous parler du projet, et vous dire que vous pouvez ouvrir une cellule à <strong>#{townhall_name}</strong>, où vous pouvez former gratuitement 6 personnes (ou plus), qu'elles soient débutantes, ou confirmées. Le modèle d'éducation de The Hacking Project n'a pas de limite en terme de nombre de moussaillons (c'est comme cela que l'on appelle les élèves), donc nous serions ravis de travailler avec <strong>#{townhall_name}</strong> !<br/><br/> </strong><strong>Charles</strong>, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80</p>"
end
#Dans cette fonction on créé le corp du mail en html(avec un peu de css).

def go_through_all_the_lines()
  array = @ws.rows.compact
  array.each{|row|  send_email_to_line(row) }
end
#On créé la fonction "go_through_all_the_lines".
#On enlève les cases vide de l'array.
#On parcours toutes les linges du googleSheet et on y appelle la fonction "send_email_to_line" créée plus haut.
#On ferme la fonction.

go_through_all_the_lines()
#On appelle la fonction "go_through_all_the_lines".

@gmail.logout
#Déconnexion.
