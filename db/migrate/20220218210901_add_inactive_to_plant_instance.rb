class AddInactiveToPlantInstance < ActiveRecord::Migration[5.2]
  def change
    add_column :plant_instances, :inactive, :boolean
  end
end
