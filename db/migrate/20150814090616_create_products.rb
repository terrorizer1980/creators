class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :type
      t.string :name
      t.string :preview
      t.integer :price
      t.text :description
      t.text :custom
      t.integer :status

      t.timestamps null: false
    end
  end
end
