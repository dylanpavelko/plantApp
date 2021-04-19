json.extract! weather_average, :id, :day, :high_level_location_id, :max_temp_f, :min_temp_f, :precip_in, :max_t_std_dev, :min_t_std_dev, :precip_std_dev, :created_at, :updated_at
json.url weather_average_url(weather_average, format: :json)
