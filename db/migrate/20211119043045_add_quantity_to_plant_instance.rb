class AddQuantityToPlantInstance < ActiveRecord::Migration[5.2]
  def change
    add_column :plant_instances, :quantity, :integer
  end
end
