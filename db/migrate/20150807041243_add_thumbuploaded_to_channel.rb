class AddThumbuploadedToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :thumbuploaded, :string
  end
end
