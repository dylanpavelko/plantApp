class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.references :species, foreign_key: true
      t.references :plant, foreign_key: true
      t.string :link

      t.timestamps
    end
  end
end
