class AddPrecipInToWeatherRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :weather_records, :precip_in, :decimal
  end
end
