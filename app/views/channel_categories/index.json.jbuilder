json.array!(@channel_categories) do |channel_category|
  json.extract! channel_category, :id, :channel_id, :description
  json.url channel_category_url(channel_category, format: :json)
end
