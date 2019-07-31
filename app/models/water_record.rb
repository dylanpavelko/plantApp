class WaterRecord < ApplicationRecord
  belongs_to :plant_instance
  
  def clean_date
      return self.moment.strftime('%m/%d/%y')
  end
end
