class AddColumnToSubscribers < ActiveRecord::Migration[7.0]
  def change
    add_column :subscribers, :latitude, :float
    add_column :subscribers, :longitude, :float
  end
end
