class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string :email
      t.integer :channel_type
      t.string :channel_id
      t.integer :status
      t.text :notes
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
