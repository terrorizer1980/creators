class AddContentHtmlAndContentSummaryHtmlToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :content_html, :text
    add_column :articles, :summary_html, :text
  end
end
