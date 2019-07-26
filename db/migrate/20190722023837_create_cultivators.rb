class CreateCultivators < ActiveRecord::Migration[5.2]
  def change
    create_table :cultivators do |t|
      t.string :name
      t.text :description
      t.belongs_to :species, foreign_key: true

      t.timestamps
    end
  end
end
