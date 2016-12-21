class AddSlugToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :slug, :string
    add_column :videos, :user_id, :integer

    add_index :videos, :slug, unique: true
  end
end
