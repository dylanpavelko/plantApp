class AddReferenceNameToPlantInstance < ActiveRecord::Migration[5.2]
  def change
    add_column :plant_instances, :reference_name, :string
  end
end
