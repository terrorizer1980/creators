class AddPaymethodToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :paymethod, :integer, default: 0
  end
end
