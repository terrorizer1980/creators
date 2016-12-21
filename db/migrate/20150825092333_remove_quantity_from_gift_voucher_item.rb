class RemoveQuantityFromGiftVoucherItem < ActiveRecord::Migration
  def change
    remove_column :gift_voucher_items, :quantity, :integer
  end
end
