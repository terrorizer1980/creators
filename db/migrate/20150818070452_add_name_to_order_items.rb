class AddNameToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :name, :string
  end
end
