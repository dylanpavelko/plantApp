class PlantInstance < ApplicationRecord
  belongs_to :plant
  belongs_to :location
  has_many :water_records
  
  def descending_water_records
    records = self.water_records.sort_by &:moment
    return records.reverse
  end

  def start_date
  	if self.planted_date != nil
  		return self.planted_date.to_date
  	else
  		return self.acquired_date
  	end
  end
  
end
