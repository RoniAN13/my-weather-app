module StaticPagesHelper
  def get_city(city)
    url = "http://dataservice.accuweather.com/locations/v1/cities/search?q=#{city}&apikey=#{ENV["accu_weather_api_key"]}"
    uri= URI(url)
    res = Net::HTTP.get_response(uri)
    return res.body
  end
  def get_weather(lat,long)
    url = "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{long}&units=metric&appid=#{ENV["open_weather_api_key"]}"
    uri= URI(url)
    res = Net::HTTP.get_response(uri)
    return res.body
  end 
  def icon_url(icon)
    return "http://openweathermap.org/img/w/#{icon}.png" 
  end

    

end
