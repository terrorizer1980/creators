module Admin::OrdersHelper
  def get_order_status_color(status) 
    case status.to_s.downcase
    when ''
      return 'teal'
    when 'ordered'
      return 'orange'
    when 'processing' 
        return 'yellow'
    when 'complete' 
      return 'olive'
    when 'delivered' 
      return 'green'
    when 'received' 
        return 'blue'
    else
      return ''
    end
  end
end