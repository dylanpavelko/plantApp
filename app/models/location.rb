class Location < ApplicationRecord
  belongs_to :high_level_location
  has_many :plants, :class_name => "PlantInstance", :foreign_key => "location_id"

end
