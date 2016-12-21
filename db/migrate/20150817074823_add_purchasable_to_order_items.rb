class AddPurchasableToOrderItems < ActiveRecord::Migration
  def change
    add_reference :order_items, :purchasable, polymorphic: true, index: true
  end
end
