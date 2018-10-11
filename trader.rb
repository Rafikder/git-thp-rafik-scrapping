require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_the_name_value_coin(url)
  cointrade = {}
  page = Nokogiri::HTML(open(url))

  cointrade[:name] = page.xpath("/html/body/div[2]/div/div[1]/div[3]/div[1]/h1/text()").text.strip
  cointrade[:value] = page.xpath("//*[@id='quote_price']/span[1]").text
  return cointrade
end


def get_all_the_urls_of_coin(website, coin_list)
  urls = []
  page = Nokogiri::HTML(open(website + coin_list))
  page.xpath("//*[@class = 'link-secondary']/@href").each do |townhall|
    urls << website + townhall.text
  end
  return urls
end


def get_all_value(website, coin_list)
  value = []
  urls = get_all_the_urls_of_coin(website, coin_list)
  urls.each do |url|
    p coin = get_the_name_value_coin(url)
    value << coin
  end
  return value
end


url = "https://coinmarketcap.com/currencies/bitcoin/"
p get_the_name_value_coin(url)

website = "https://coinmarketcap.com"
coin_list = "/all/views/all/"

puts get_all_value(website, coin_list)
