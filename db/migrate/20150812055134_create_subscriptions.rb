class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :paymethod
      t.integer :billingperiod
      t.string :paypal_customer_token
      t.string :paypal_recurring_profile_token
      t.decimal :paypal_subscription_amount
      t.string :paypal_subscription_description

      t.timestamps null: false
    end
  end
end
