class AddAnonymousToGiftVouchers < ActiveRecord::Migration
  def change
    add_column :gift_vouchers, :anonymous, :boolean
  end
end
