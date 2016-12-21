class AddTemptokenToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :paypal_payment_token, :string
  end
end
