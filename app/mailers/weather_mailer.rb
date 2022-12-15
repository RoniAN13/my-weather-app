class WeatherMailer < ApplicationMailer
    def daily_weather(subscriber,details,weather_info)
        @subscriber = subscriber
        @details = details
        @weather_info = weather_info
        mail(to: @subscriber.email, subject: "Daily weather")
      
      end
     
end
