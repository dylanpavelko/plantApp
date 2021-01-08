class AddBbchProfileToSpecies < ActiveRecord::Migration[5.2]
  def change
    add_reference :species, :bbch_profile, foreign_key: true
  end
end
