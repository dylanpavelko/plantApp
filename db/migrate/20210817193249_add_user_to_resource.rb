class AddUserToResource < ActiveRecord::Migration[5.2]
  def change
    add_reference :resources, :user, foreign_key: true
  end
end
