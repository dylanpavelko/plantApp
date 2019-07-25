class Order < ApplicationRecord
    belongs_to :plant_class, :class_name => "PlantClass", :foreign_key => "plant_class_id"
    
end
