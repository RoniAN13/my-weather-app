class CreateSearchedCities < ActiveRecord::Migration[7.0]
  def change
    create_table :searched_cities do |t|
      t.string :city
      t.string :country
      t.string :region
      t.string :weather_description
      t.string :icon
      t.float :temp
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
