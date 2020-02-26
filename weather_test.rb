require "geocoder"
require "forecast_io"
require "httparty"                            

# enter your Dark Sky API key here
ForecastIO.api_key = "384785e41762fc082ca09c82189b33f4"

lat_test = "42.0574063"
loc_test = "-87.6722787"

# puts @loc_test

forecast = ForecastIO.forecast(lat_test,loc_test).to_hash

pp forecast["currently"]

url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9e26233f3dbf43bbb4ad366bb267c58d"
news = HTTParty.get(url).parsed_response.to_hash

puts news.keys

for summary in news["articles"]
    # the for loop does days = forecast["daily"]["data"][0]
    puts "A high temperature of #{summary["description"]} and #{summary["source"]["name"]}"
end