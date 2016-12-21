json.array!(@gift_voucher_items) do |gift_voucher_item|
  json.extract! gift_voucher_item, :id, :name, :description, :gift_voucher_id, :product_id, :discount, :quantity, :status
  json.url gift_voucher_item_url(gift_voucher_item, format: :json)
end
