class AddMinTempFToWeatherRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :weather_records, :min_temp_f, :decimal
  end
end
