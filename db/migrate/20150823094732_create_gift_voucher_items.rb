class CreateGiftVoucherItems < ActiveRecord::Migration
  def change
    create_table :gift_voucher_items do |t|
      t.string :name
      t.string :description
      t.references :gift_voucher, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.integer :discount
      t.integer :quantity
      t.integer :status

      t.timestamps null: false
    end
  end
end
