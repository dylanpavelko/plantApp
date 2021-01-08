class CreateBbchStages < ActiveRecord::Migration[5.2]
  def change
    create_table :bbch_stages do |t|
      t.integer :code
      t.string :description
      t.string :note
      t.references :bbch_profile, foreign_key: true

      t.timestamps
    end
  end
end
