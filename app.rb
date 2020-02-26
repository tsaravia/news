require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "384785e41762fc082ca09c82189b33f4"

url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9e26233f3dbf43bbb4ad366bb267c58d"
news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output

get "/" do
  # show a view that asks for the location
  view"ask"
end

get "/news" do
  # do everything else
results = Geocoder.search(params["location"])
lat_long = results.first.coordinates # => [lat, long]
@location = params["location"]
@latitude = lat_long[0] 
@longitude = lat_long[1]
# "#{lat_long[0]} #{lat_long[1]}"

# "#{@latitude}"

forecast = ForecastIO.forecast(@latitude,@longitude).to_hash

@forecast = forecast["hourly"]["summary"]
@current_temp = forecast["currently"]["temperature"]
@current_summary = forecast["currently"]["summary"]
@precip_type = forecast["currently"]["precipType"]
@precip_perc = forecast["currently"]["precipProbability"]
@forecast_hours = forecast["hourly"]["data"][0..11]
@forecast_weekly = forecast["daily"]["summary"]

@news = news
@headlines = news["articles"]

view"news"
end

