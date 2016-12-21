class AddRecruiterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recruiter, :boolean, default: 0
  end
end
