json.array!(@ppipns) do |ppipn|
  json.extract! ppipn, :id, :params
  json.url ppipn_url(ppipn, format: :json)
end
