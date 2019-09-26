class AddLongToHighLevelLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :high_level_locations, :long, :decimal
  end
end
