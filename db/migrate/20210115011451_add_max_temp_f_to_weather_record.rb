class AddMaxTempFToWeatherRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :weather_records, :max_temp_f, :decimal
  end
end
