json.array!(@gift_vouchers) do |gift_voucher|
  json.extract! gift_voucher, :id, :name, :message, :from_user_id, :user_id
  json.url gift_voucher_url(gift_voucher, format: :json)
end
