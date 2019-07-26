class AddPlantClassToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :plant_class, foreign_key: true
  end
end
