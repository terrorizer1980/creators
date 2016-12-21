json.array!(@songs) do |song|
  json.extract! song, :id, :name, :category, :vidurl, :description, :user_id, :slug
  json.url song_url(song, format: :json)
end
