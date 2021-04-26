class CreateGrowthStages < ActiveRecord::Migration[5.2]
  def change
    create_table :growth_stages do |t|
      t.references :species, foreign_key: true
      t.integer :bbch_code
      t.decimal :cold_damage_risk
      t.decimal :required_low
      t.decimal :growth_base
      t.decimal :required_high
      t.decimal :growth_cutoff
      t.decimal :heat_damage_risk
      t.decimal :min_days
      t.decimal :min_agdd
      t.integer :from_bbch_code
      t.boolean :harvestable

      t.timestamps
    end
  end
end
