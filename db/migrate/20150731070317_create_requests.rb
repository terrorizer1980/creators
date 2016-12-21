class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user, index: true, foreign_key: true
      t.references :channel, index: true, foreign_key: true
      t.integer :reqtype, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.integer :assigned_to

      t.timestamps null: false
    end
  end
end
