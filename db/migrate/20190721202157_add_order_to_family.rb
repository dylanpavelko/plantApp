class AddOrderToFamily < ActiveRecord::Migration[5.2]
  def change
    add_reference :families, :order, foreign_key: true
  end
end
