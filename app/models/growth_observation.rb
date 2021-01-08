class GrowthObservation < ApplicationRecord
  belongs_to :plant_instance
  belongs_to :bbch_stage
end
