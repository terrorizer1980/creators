class AddPpsdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :paypal_subscription_description, :string
    change_column :profiles, :paypal_subscription_amount, :decimal
  end
end
