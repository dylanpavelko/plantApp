class AddCommonNameToDivision < ActiveRecord::Migration[5.2]
  def change
    add_column :divisions, :common_name, :string
  end
end
