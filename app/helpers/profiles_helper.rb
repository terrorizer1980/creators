module ProfilesHelper
  
  # TODO: give me the advisor and artist with the least number of full_client or free clients
  # For now, just grab the rob and harv
  
  def find_preferred_artist_id
    preferredUser = User.find_by(email: 'harv@101.net')
    preferredUser.blank? ? nil : preferredUser.id
  end
  
  def find_preferred_advisor_id
    preferredUser = User.find_by(email: 'rhof@101.net')
    preferredUser.blank? ? nil : preferredUser.id
  end
  
end
