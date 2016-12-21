class AddBillingfieldsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_payment_date, :datetime
    add_column :subscriptions, :next_billing_date, :datetime
    add_column :subscriptions, :resubcredit, :float, scale: 2
  end
end
