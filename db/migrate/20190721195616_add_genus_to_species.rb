class AddGenusToSpecies < ActiveRecord::Migration[5.2]
  def change
    add_reference :species, :genus, foreign_key: true
  end
end
