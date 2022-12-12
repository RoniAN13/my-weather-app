# Preview all emails at http://localhost:3000/rails/mailers/weather_mailer
class WeatherMailerPreview < ActionMailer::Preview
    def daily_weather
        @subscriber = Subscriber.first
       
        res = Geocoder.search([@subscriber.latitude,@subscriber.longitude])
        @details = res.first
        url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@details.latitude}&lon=#{@details.longitude}&units=metric&appid=#{ENV["open_weather_api_key"]}"
        uri= URI(url)
        res = Net::HTTP.get_response(uri)
        @weather_info =   JSON.parse(res.body)
        WeatherMailer.daily_weather(@subscriber,@details,@weather_info)
      end
end
