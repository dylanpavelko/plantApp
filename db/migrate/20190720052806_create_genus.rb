class CreateGenus < ActiveRecord::Migration[5.2]
  def change
    create_table :genus do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
