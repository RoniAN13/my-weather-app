class SearchedCity < ApplicationRecord
    validates_presence_of :city,:country,:region,:weather_description,:icon,:temp,:latitude,:longitude
end
