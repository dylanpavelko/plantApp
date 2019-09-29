class AddUserToHighLevelLocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :high_level_locations, :user, foreign_key: true
  end
end
