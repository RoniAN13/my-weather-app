require 'net/http'
class SubscribersController < ApplicationController
    include StaticPagesHelper
    def create
    
        @subscriber = Subscriber.new(sub_params)
      
        if @subscriber.save
          flash[:notice] = "#{@subscriber.email} subscribed successfully"
          res = Geocoder.search([@subscriber.latitude,@subscriber.longitude])
        @details = res.first
        url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@details.latitude}&lon=#{@details.longitude}&units=metric&appid=#{ENV["open_weather_api_key"]}"
        uri= URI(url)
        res = Net::HTTP.get_response(uri)
        @weather_info =   JSON.parse(res.body)
        WeatherMailer.daily_weather(@subscriber,@details,@weather_info).deliver_now
          redirect_to root_path
        else
          flash[:alert] = @subscriber.errors.full_messages[0]
          redirect_to root_path
        end

    end 
    def unsubscribe
      @subscriber = Subscriber&.find_by(email: params[:email])
      unless @subscriber
        flash[:notice] = "This user was already unsubscribed"
        redirect_to root_path
      end
    end    
    def destroy
      @subscriber = Subscriber&.find(params[:id])

    if @subscriber.destroy
      flash[:notice] = " #{@subscriber.email} has been successfully unsubscribed"
      redirect_to root_path
    else
      flash.now[:alert] = "Apologies! #{@subscriber.email} couldn't be unsubscribed. Please contact from@gmail.com if the problem persists."
    end
    end   
private
    def sub_params
        params.require(:subscriber).permit(:email,:latitude,:longitude)
      end 
end
