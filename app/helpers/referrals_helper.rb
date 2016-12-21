module ReferralsHelper
  
  def get_referral_status_color(status) 
    case status.to_s.downcase
    when 'prospective' 
        return 'green'
      when 'contacted' 
        return 'olive'
      when 'pitched' 
        return 'yellow'
      when 'trialling' 
        return 'orange'
      when 'subscribed' 
        return 'red'
      when 'claimed' 
        return 'violet'
      when 'paid' 
        return 'blue'
      else
        return ''
    end
  end
  
end