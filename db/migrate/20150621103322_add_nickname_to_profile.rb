class AddNicknameToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :nickname, :string
    add_index :profiles, :nickname, unique: true
  end
end
