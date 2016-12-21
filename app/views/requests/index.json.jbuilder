json.array!(@requests) do |request|
  json.extract! request, :id, :user_id, :channel_id, :type, :status, :assigned_to
  json.url request_url(request, format: :json)
end
