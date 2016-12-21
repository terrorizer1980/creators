class AddPublishableToNews < ActiveRecord::Migration
  def change
    add_column :news, :publish_at, :datetime
    add_column :news, :thumburl, :string
  end
end
