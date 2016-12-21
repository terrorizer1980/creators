json.array!(@plans) do |plan|
  json.extract! plan, :id, :name, :price, :credits, :period
  json.url plan_url(plan, format: :json)
end
