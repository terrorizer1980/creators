class CreateTxes < ActiveRecord::Migration
  def change
    create_table :txes do |t|
      t.references :user,   index: true, foreign_key: true
      t.integer :txtype,            default: 0, null: false
      t.integer :currency,          default: 0, null: false
      t.integer :direction,         default: 0, null: false
      t.integer :amount_cents,      default: 0, null: false
      t.integer :balance_cents,     null: false
      t.integer :amount_credits,    default: 0, null: false
      t.integer :balance_credits,   null: false
      t.string :notes

      t.timestamps null: false
    end
  end
end
