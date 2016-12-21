json.array!(@motion_graphic_collections) do |motion_graphic_collection|
  json.extract! motion_graphic_collection, :id
  json.url motion_graphic_collection_url(motion_graphic_collection, format: :json)
end
