json.array!(@article_collections) do |article_collection|
  json.extract! article_collection, :id, :name, :description, :picture, :slug, :category
  json.url article_collection_url(article_collection, format: :json)
end
