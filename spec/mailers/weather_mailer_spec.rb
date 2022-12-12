require "rails_helper"

RSpec.describe WeatherMailer, type: :mailer do
  before :each do
    @subscriber = Subscriber.create(id:1,email:"example@gmail.com")
    access_token = ENV["ipinfo_access_token"]
        handler = IPinfo::create(access_token)
        ip_address = Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
        @details = handler.details(ip_address)
        url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@details.latitude}&lon=#{@details.longitude}&units=metric&appid=#{ENV["open_weather_api_key"]}"
        uri= URI(url)
        res = Net::HTTP.get_response(uri)
        @weather_info =   JSON.parse(res.body)
end
  describe "daily-catfact" do
    
    
        let(:mail) {WeatherMailer.daily_weather(@subscriber,@details,@weather_info)}
    it "renders the headers" do
      expect(mail.subject).to eq("Daily weather")
      expect(mail.from).to eq(["from@example.com"])
       expect(mail.to).to eq(["example@gmail.com"])
    end

   
  end
end
