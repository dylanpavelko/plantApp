class AddUserToGrowthObservation < ActiveRecord::Migration[5.2]
  def change
    add_reference :growth_observations, :user, foreign_key: true
  end
end
