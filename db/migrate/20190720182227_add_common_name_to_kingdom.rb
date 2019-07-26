class AddCommonNameToKingdom < ActiveRecord::Migration[5.2]
  def change
    add_column :kingdoms, :common_name, :string
  end
end
