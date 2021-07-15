json.(@plant, 
	:id, 
	:scientific_name_with_common_names, 
	:common_names,
	:image_url,
	:variety,
	:cultivator, 
	:species, 
	:genus, 
	:family, 
	:order,
	:plant_class,
	:division,
	:kingdom)

json.array! @resources do |r|
	json.id r.id
	json.name r.name
	json.link r.link
end