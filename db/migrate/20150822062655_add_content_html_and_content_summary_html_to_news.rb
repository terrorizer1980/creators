class AddContentHtmlAndContentSummaryHtmlToNews < ActiveRecord::Migration
  def change
    add_column :news, :content_html, :text
    add_column :news, :summary_html, :text
  end
end
