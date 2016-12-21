class CreateGiftVouchers < ActiveRecord::Migration
  def change
    create_table :gift_vouchers do |t|
      t.string :name
      t.string :message

# Removed as it was messing up the prouduction migration (mysql). Will Add another migration later to resolve this.
# RH
#      t.references :to_user, references: :users, index: true, foreign_key: true
#      t.references :from_user, references: :users, index: true, foreign_key: true

      t.string :to_text  
      t.string :from_text

      t.timestamps null: false
    end
  end
end
