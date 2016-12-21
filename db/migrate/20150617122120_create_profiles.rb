class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true
      t.string :fname
      t.string :lname
      t.date :birthday
      t.integer :category, default: 0, null: false
      t.string :paypal
      t.string :skype
      t.string :country_code
      t.timestamps null: false
    end
    add_foreign_key :profiles, :users
  end
end
