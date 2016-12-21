class AddUserToPresets < ActiveRecord::Migration
  def change
    add_reference :presets, :user, index: true, foreign_key: true
  end
end
