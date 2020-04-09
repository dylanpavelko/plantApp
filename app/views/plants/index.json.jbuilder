json.plants do
  json.array! @allPlants, :id, :scientific_name_with_common_names, :image_url  
end