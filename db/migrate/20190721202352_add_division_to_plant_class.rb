class AddDivisionToPlantClass < ActiveRecord::Migration[5.2]
  def change
    add_reference :plant_classes, :division, foreign_key: true
  end
end
