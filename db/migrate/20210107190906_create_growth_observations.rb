class CreateGrowthObservations < ActiveRecord::Migration[5.2]
  def change
    create_table :growth_observations do |t|
      t.references :plant_instance, foreign_key: true
      t.date :observation_date
      t.references :bbch_stage, foreign_key: true
      t.integer :percent_at_stage

      t.timestamps
    end
  end
end
