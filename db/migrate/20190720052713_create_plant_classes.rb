class CreatePlantClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :plant_classes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
