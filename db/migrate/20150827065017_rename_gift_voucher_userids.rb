class RenameGiftVoucherUserids < ActiveRecord::Migration
  def change
    rename_column :gift_vouchers, :to_user, :to_user_id
		rename_column :gift_vouchers, :from_user, :from_user_id
  end
end
