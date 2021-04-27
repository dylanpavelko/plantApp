class AddNameToResource < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :name, :string
  end
end
