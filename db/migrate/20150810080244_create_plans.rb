class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :price
      t.integer :credits
      t.integer :period

      t.timestamps null: false
    end
  end
end
