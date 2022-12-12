require 'rails_helper'
RSpec.describe 'Search for a city', type: :feature do
  before :each do
    SearchedCity.create!(city:"Beirut",country:"Lebanon",region:"Middle East",latitude:0.00,longitude:0.00,weather_description:"clear sky",temp:11.0,icon:"01f")
    @searched_cities = SearchedCity.order("created_at DESC").limit(10)
    access_token = ENV["ipinfo_access_token"]
      handler = IPinfo::create(access_token)
      ip_address = Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
      @details = handler.details(ip_address)
      url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@details.latitude}&lon=#{@details.longitude}&units=metric&appid=#{ENV["open_weather_api_key"]}"
    uri= URI(url)
    res = Net::HTTP.get_response(uri)
      @weather_info =   JSON.parse(res.body)
  end
    scenario "type a valid city" do
      
    
        visit root_path
      
        fill_in :search_city_name, with: "Beirut"
        click_on 'Search'
        uri = URI("http://dataservice.accuweather.com/locations/v1/cities/search?q=Beirut&apikey=#{ENV["accu_weather_api_key"]}")
       res = Net::HTTP.get_response(uri)
       weather_response = Net::HTTP.get_response(URI("https://api.openweathermap.org/data/2.5/weather?lat=#{JSON.parse(res.body)[0]["GeoPosition"]["Latitude"]}&lon=#{JSON.parse(res.body)[0]["GeoPosition"]["Longitude"]}&units=metric&appid=#{ENV["open_weather_api_key"]}"))
     
       expect(JSON.parse(res.body)[0]).to have_key("LocalizedName")
       expect(JSON.parse(weather_response.body)).to have_key("weather")
        expect(page).to have_text("Beirut")
  
      end
      scenario "type an invalid city" do
      
    
        visit root_path
      
        fill_in :search_city_name, with: "tripol"
        click_on 'Search'
      
        expect(page).to have_text("No such city name")
  
      end
    scenario "get 10 past searched cities" do 
      visit root_path
      @searched_cities.each do |searched_city|
        expect(page).to have_text(searched_city.city)
        expect(page).to have_text(searched_city.temp.to_i)
      
      end
    end
    scenario "subscribe to daily weather" do
      visit root_path
      fill_in "subscriber_email",with: "example@example.com"
      click_on "Subscribe"
      expect(page).to have_text("example@example.com subscribed successfully")
    end
    scenario "used email for subscribe to daily weather" do
      visit root_path
      fill_in "subscriber_email",with: "example@gmail.com"
      click_on "Subscribe"
      expect(page).to have_text("Email has already been taken")
    end
    scenario "invalid email for subscribe to daily weather" do
      visit root_path
      fill_in "subscriber_email",with: "example@gmail"
      click_on "Subscribe"
      expect(page).to have_text("Email is invalid")
    end
end