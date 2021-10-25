json.extract! plant, :id, :scientific_name_with_common_names, :species_id, :variety_id, :created_at, :updated_at, :image_url
json.url plant_url(plant, format: :json)
