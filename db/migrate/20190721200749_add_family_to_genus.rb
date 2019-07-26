class AddFamilyToGenus < ActiveRecord::Migration[5.2]
  def change
    add_reference :genus, :family, foreign_key: true
  end
end
