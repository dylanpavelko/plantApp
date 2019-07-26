class AddCultivatorToPlant < ActiveRecord::Migration[5.2]
  def change
    add_reference :plants, :cultivator, foreign_key: true
  end
end
