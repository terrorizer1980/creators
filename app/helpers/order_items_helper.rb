module OrderItemsHelper
  
  private
  
  def find_order_item_parent(order_item)
    order_item.order.present? ? [order_item.order.becomes(Order)] : [order_item.purchasable, :order_items]
  end
  
end
