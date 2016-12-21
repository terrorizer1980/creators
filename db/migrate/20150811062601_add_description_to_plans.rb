class AddDescriptionToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :description, :string
    add_column :plans, :includes_review, :boolean, default: true
    add_column :plans, :available, :boolean, default: true
  end
end
