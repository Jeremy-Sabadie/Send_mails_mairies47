require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'watir'

def get_the_email_of_a_townhal_from_its_webpage(url)
  doc = Nokogiri::HTML(open(url))
  email = doc.xpath('/html/body/table/tr[3]/td/table/tr[1]/td[1]/table[4]/tr[2]/td/table/tr[4]/td[2]/p/font')
  email.text
end
#On créé une foction "get_the_email_of_a_townhal_from_its_webpage" qui prend comme argument "url".
#On créé une variable qui appelle Nokogiri sur l'url.
#On créé une deuxième variable qui correspond à l'emplacement de l'adresse mail dans la page html.
#On affiche l'adresse mail correspondante.

def get_all_the_urls_of_gironde_townhalls()
  doc = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/lot-et-garonne.html"))
  urls = doc.css('html body table tr td table tr td table tr td table tr td p a.lientxt')
  urls.each{|url|  url["href"]= right_url(url["href"])}
  urls
end
#On créé la fonction "get_all_the_urls_of_val_doise_townhalls".
#On créé une variable qui qui appelle l'ouverture de l'annuaire de l'annuaire des mairies.
#On créé une autre variable qui correspond au liens trouvés avec le css sur la page ouverte.
#on sépare chaque liens et on créé une variable qui est égale aux liens qu'on rectifie avec la fonction "right_url" construite plus bas dans le code.

def right_url(url)
  url = 'http://annuaire-des-mairies.com' + url.split('').drop(1)*''
end
#On créé une fonction "right_url" qui enlève le premier caractère (.)des urls fournies par la fonction précédente et qui les remplace par rien.

def rangement
  res = []
  get_all_the_urls_of_gironde_townhalls().each do |mairie_url|
	nom = mairie_url.text
	mail = get_the_email_of_a_townhal_from_its_webpage(mairie_url["href"])
	res << {:name =>nom , :email =>mail}
  end
  res
end
#On créé une fonction "rangement".
#On créé un tableau vide par défaut nommé "res".
#On créé une variable "nom" pour y stocker noms des mairies.
#On créé une autre variable "mail" pour y stocker les adresses mails des mairies.
#On ajoute au tableau "res" un hash pour chaque mairies qui contient le nom et le mail.
#On ferme la boucle.
#On ferme la fonction "rangement".


