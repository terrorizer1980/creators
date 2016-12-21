class AddGiftVoucherToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :gift_voucher, index: true, foreign_key: true
  end
end
