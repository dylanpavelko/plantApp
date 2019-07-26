class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.belongs_to :species, foreign_key: true
      t.belongs_to :variety, foreign_key: true

      t.timestamps
    end
  end
end
