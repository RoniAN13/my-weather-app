class WeatherMailer < ApplicationMailer
    def daily_weather(subscriber,details,weather_info)
        @subscriber = subscriber
        @details = details
        @weather_info = weather_info
        bootstrap_mail(to: @subscriber.email, subject: "Daily weather") do |format|
          format.html { layout 'custom_bootstrap_layout' }
          format.text 
        end
      end
     
end
