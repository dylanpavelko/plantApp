class PlantInstance < ApplicationRecord
  belongs_to :plant
  belongs_to :location
end
