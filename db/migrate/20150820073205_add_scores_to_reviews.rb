class AddScoresToReviews < ActiveRecord::Migration
  def change
  	remove_column :reviews, :subs, :integer
    add_column :reviews, :total_score, :integer, defaut: 0
    add_column :reviews, :content_score, :integer, defaut: 0
    add_column :reviews, :subscribers, :integer, default: 0
    add_column :reviews, :channel_views, :integer, default: 0
    add_column :reviews, :videos, :integer, default: 0
    add_column :reviews, :content_notes, :text
    add_column :reviews, :optimization_score, :integer, defaut: 0
    add_column :reviews, :optimization_notes, :text
    add_column :reviews, :promotion_score, :integer, defaut: 0
    add_column :reviews, :promotion_notes, :text
    add_column :reviews, :engagement_score, :integer, defaut: 0
    add_column :reviews, :engagement_notes, :text, defaut: 0
    add_column :reviews, :summary, :text
  end
end
