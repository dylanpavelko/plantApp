class PlantClass < ApplicationRecord
    belongs_to :division, :class_name => "Division", :foreign_key => "division_id"
end
