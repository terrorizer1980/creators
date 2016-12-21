json.array!(@motion_graphic_customizations) do |motion_graphic_customization|
  json.extract! motion_graphic_customization, :id, :user_id, :motion_graphic_id, :custom_field_data
  json.url motion_graphic_customization_url(motion_graphic_customization, format: :json)
end
