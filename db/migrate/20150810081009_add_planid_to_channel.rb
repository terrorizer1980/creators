class AddPlanidToChannel < ActiveRecord::Migration
  def change
    add_reference :channels, :plan, index: true, foreign_key: true
  end
end
