class AddFieldsToPlantInstance < ActiveRecord::Migration[5.2]
  def change
    add_column :plant_instances, :planted_date, :datetime
    add_column :plant_instances, :acquired_date, :date
    add_column :plant_instances, :propagation_type, :int
  end
end
