
class WeatherMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Subscriber.find_each do |subscriber|
     
      res = Geocoder.search([subscriber.latitude,subscriber.longitude])
      @details = res.first
      url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@details.latitude}&lon=#{@details.longitude}&units=metric&appid=#{ENV["open_weather_api_key"]}"
      uri= URI(url)
      res = Net::HTTP.get_response(uri)
      @weather_info =   JSON.parse(res.body)
      WeatherMailer.daily_weather(subscriber,@details,@weather_info).deliver_now
    end
  end
end
