class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.belongs_to :kingdom, foreign_key: true
      t.belongs_to :division, foreign_key: true
      t.belongs_to :plant_class, foreign_key: true
      t.belongs_to :order, foreign_key: true
      t.belongs_to :family, foreign_key: true
      t.belongs_to :genus, foreign_key: true
      t.belongs_to :species, foreign_key: true
      t.belongs_to :variety, foreign_key: true

      t.timestamps
    end
  end
end
