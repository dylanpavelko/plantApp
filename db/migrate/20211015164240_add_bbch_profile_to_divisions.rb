class AddBbchProfileToDivisions < ActiveRecord::Migration[5.2]
  def change
    add_reference :divisions, :bbch_profile, foreign_key: true
  end
end
