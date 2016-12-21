class AddBaseRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :baserole, :integer, null: false, default: 0
    add_column :users, :staffrole, :integer, null: false, default: 0
    add_column :users, :clientstatus, :integer, null: false, default: 0
    remove_column :users, :admin
  end
end
