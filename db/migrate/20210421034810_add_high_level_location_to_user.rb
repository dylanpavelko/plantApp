class AddHighLevelLocationToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :high_level_location, foreign_key: true
  end
end
