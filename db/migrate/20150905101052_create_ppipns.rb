class CreatePpipns < ActiveRecord::Migration
  def change
    create_table :ppipns do |t|
      t.text :params

      t.timestamps null: false
    end
  end
end
