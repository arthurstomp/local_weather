require 'sinatra/base'
require 'sinatra/json'
require 'httparty'
require 'yaml'

class WeatherApi
  include HTTParty
  base_uri 'https://api.openweathermap.org/data/2.5/'
  @@api_key = YAML.load_file('api_key.yml')['api_key']

  def self.weather(position)
    get("/weather?lat=#{position[:lat]}&lon=#{position[:lon]}&APPID=#{@@api_key}")
  end
end

class Weather < Sinatra::Base
  get '/' do
    haml :index
  end

  get '/weather/:lat/:lon' do
    position = {lat: params[:lat], lon: params[:lon]}
    res = WeatherApi.weather(position)
    final_res = parse_weather(res)
    json final_res
  end

  def parse_weather(raw_weather)
    p = {}
    w = raw_weather['weather'][0]
    m = raw_weather['main']
    p[:main] = w['main']
    p[:description] = w['description']
    p[:temp] = m['temp']
    p[:temp_min] = m['temp_min']
    p[:temp_max] = m['temp_max']
    p[:humidity] = m['humidity']
    p
  end

  run! if app_file == $0
end
