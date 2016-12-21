class AddStatusToGiftVoucher < ActiveRecord::Migration
  def change
    add_column :gift_vouchers, :status, :integer
  end
end
