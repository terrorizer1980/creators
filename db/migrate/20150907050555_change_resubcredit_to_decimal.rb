class ChangeResubcreditToDecimal < ActiveRecord::Migration
  def change
    change_column :subscriptions, :resubcredit, :decimal, precision: 8, scale: 2
  end
end
