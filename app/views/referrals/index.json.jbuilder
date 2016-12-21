json.array!(@referrals) do |referral|
  json.extract! referral, :id, :email, :channel_type, :channel_id, :status, :notes, :user_id
  json.url referral_url(referral, format: :json)
end
