class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :channel, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true  # channel manager, not the channel owner
      t.integer :subs
      t.datetime :completed_at
      t.datetime :scheduled_for
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end
  end
end
