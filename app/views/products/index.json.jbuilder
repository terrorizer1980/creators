json.array!(@products) do |product|
  json.extract! product, :id, :type, :name, :preview, :price, :description, :custom, :status
  json.url product_url(product, format: :json)
end
