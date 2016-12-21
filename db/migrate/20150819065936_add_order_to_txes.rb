class AddOrderToTxes < ActiveRecord::Migration
  def change
    add_reference :txes, :order, index: true, foreign_key: true
  end
end
