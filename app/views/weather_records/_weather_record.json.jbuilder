json.extract! weather_record, :id, :date, :report.text, :high_level_location_id, :created_at, :updated_at
json.url weather_record_url(weather_record, format: :json)
