
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_depute(depute_url)
  depute = {}
  page = Nokogiri::HTML(open(depute_url))
  id = page.xpath("//*[@id='haut-contenu-page']/article/div[2]/h1").text.split
  depute[:gender] = id[0]
  depute[:firstname] = id[1]
  depute[:lastname] = id[2]
  depute[:mail] = page.xpath("//*[@id='deputes-contact']/section/dl/dd[1]/a/@href").text.split(':')[1]
  depute
end

def get_all_the_urls_of_depute(website_url, page)
  urls =
  [

  ]
  page = Nokogiri::HTML(open(website_url + page))
  page.xpath("//*[@id='deputes-list']/div/ul/li/a/@href").each do |depute|
    urls << website_url + depute.text
  end
  urls
end

def get_all_depute(website_url, page)
  depute = []
  urls = get_all_the_urls_of_depute(website_url, page)
  urls.each do |url|
    p contact = get_depute(url)
    depute << contact
  end
  depute
end

url = "http://www2.assemblee-nationale.fr"
page = "/deputes/liste/alphabetique"

puts get_all_depute(url, page)
