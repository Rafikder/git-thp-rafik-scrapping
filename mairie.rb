require 'rubygems'
require 'nokogiri'
require 'open-uri'
=begin
townhalll_email = "http://annuaire-des-mairies.com/95/vaureal.html"
def get_the_email_of_a_townhal_from_its_webpage(townhalll_email)
    page = Nokogiri::HTML(open(townhalll_email))
    email = page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
puts email
end

get_the_email_of_a_townhal_from_its_webpage(townhalll_email)


townhalll_urls = "http://annuaire-des-mairies.com/val-d-oise.html"
def get_all_the_urls_of_val_doise_townhalls(townhalll_urls)
  page = Nokogiri::HTML(open(townhalll_urls))
  urls = page.xpath("//*[@id='lientxt']/table/tbody/tr[2]/td/table")
  puts urls
end
  get_all_the_urls_of_val_doise_townhalls(townhalll_urls)
#//*[@id="voyance-par-telephone"]/table/tbody/tr[2]/td/table
=end


def get_the_email_of_a_townhall_from_its_webpage(townhall_url)
  contact = {}
  page = Nokogiri::HTML(open(townhall_url))
  contact[:name] = page.xpath("/html/body/div/main/section[1]/div/div/div/p[1]/strong[1]/a").text
  contact[:email] = page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
  p contact
  return contact
end

def get_all_the_urls_of_val_doise_townhalls(website, town_list)
  urls = []
  page = Nokogiri::HTML(open(website + town_list))
  page.xpath("//*[@class = 'lientxt']/@href").each do |townhall|
    urls << website + townhall.text[1..-1]
  end
  return urls
end

def get_all_emails(website, town_list)
  emails = []
  urls = get_all_the_urls_of_val_doise_townhalls(website, town_list)
  urls.each do |url|
    emails << get_the_email_of_a_townhall_from_its_webpage(url)
  end
  return emails
end

website = "http://annuaire-des-mairies.com"
town_list = "/val-d-oise.html"
url = "http://annuaire-des-mairies.com/95/vaureal.html"
#puts get_the_email_of_a_townhall_from_its_webpage(url)

puts get_all_emails(website, town_list)
