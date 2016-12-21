json.array!(@videos) do |video|
  json.extract! video, :id, :channel_id, :name, :progress
  json.url video_url(video, format: :json)
end
