require 'net/http'

class StaticPagesController < ApplicationController
include StaticPagesHelper
  def home
    @searched_cities = SearchedCity.order("created_at DESC").limit(10)
    @subscriber = Subscriber.new
    
      ip_address = request.remote_ip
      @details = handler.details(ip_address)
      @weather_info =   JSON.parse(get_weather(@details.latitude,@details.longitude))
    
 

    if params[:search].present? && !params[:search].blank?
      @data = JSON.parse(get_city(params[:search][:city_name]))
      if @data && @data.any?
          lat = @data.first["GeoPosition"]["Latitude"]
          long = @data.first["GeoPosition"]["Longitude"]
        @weather = JSON.parse(get_weather(lat,long))
        if @weather
            @icon = "http://openweathermap.org/img/w/#{@weather["weather"][0]["icon"]}.png"
           
              SearchedCity.create!(city:@data.first["LocalizedName"],country:@data.first["Country"]["LocalizedName"],
                                  region:@data.first["Region"]["LocalizedName"],latitude:lat,longitude:long,
                                  weather_description:@weather["weather"][0]["description"],icon:@weather["weather"][0]["icon"],
                                  temp: @weather["main"]["temp"])
              @searched_cities = SearchedCity.order("created_at DESC").limit(10).where.not(id:SearchedCity.last.id)
          end
      end   
    end
  end
end
