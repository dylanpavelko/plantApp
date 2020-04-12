class AddOpenFarmIdToPlant < ActiveRecord::Migration[5.2]
  def change
    add_column :plants, :OpenFarmID, :string
  end
end
