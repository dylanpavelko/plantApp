class AddInactiveToPlantInstance < ActiveRecord::Migration[5.2]
  def change
    add_column :plant_instances, :inactive, :boolean,  null: false, default: false
  end
end
