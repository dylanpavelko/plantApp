class AddSproutDateToPlantInstance < ActiveRecord::Migration[5.2]
  def change
    add_column :plant_instances, :sprout_date, :date
  end
end
