class AddKingdomToDivision < ActiveRecord::Migration[5.2]
  def change
    add_reference :divisions, :kingdom, foreign_key: true
  end
end
