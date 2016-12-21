class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :product, index: true, foreign_key: true
      t.text :custom
      t.integer :cost
      t.datetime :ordered
      t.datetime :requested
      t.datetime :delivered

      t.timestamps null: false
    end
  end
end
