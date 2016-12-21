class AddRefsToGiftVouchers < ActiveRecord::Migration
  def change

#      t.references :to_user, references: :users, index: true, foreign_key: true
#      t.references :from_user, references: :users, index: true, foreign_key: true
    add_column :gift_vouchers, :to_user, :integer
		add_column :gift_vouchers, :from_user, :integer
  end
end
