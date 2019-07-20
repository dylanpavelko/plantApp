class CreateCommonNames < ActiveRecord::Migration[5.2]
  def change
    create_table :common_names do |t|
      t.string :name
      t.belongs_to :plant, foreign_key: true

      t.timestamps
    end
  end
end
