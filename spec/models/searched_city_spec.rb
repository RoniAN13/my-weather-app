require 'rails_helper'

RSpec.describe SearchedCity, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:region) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:temp) }
    it { should validate_presence_of(:icon) }
    it { should validate_presence_of(:weather_description) }
  
  end
end
