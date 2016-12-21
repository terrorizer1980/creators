module ApplicationHelper
    
  def markdown(blogtext)
    renderOptions = {hard_wrap: true, filter_html: true}
    markdownOptions = {autolink: true, no_intra_emphasis: true}
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(renderOptions), markdownOptions)
    markdown.render(blogtext).html_safe
  end
  
  def log_to_hipchat(message)
    LogToHipchatJob.perform_later message
  end
  
  def time_ago_in_words_suffix(dtt)
    dtt.blank? ?
      'never' : 
      (time_ago_in_words(dtt.to_s) + ' ' + (dtt > DateTime.now ? 'from now' : 'ago'))
  end

  def incrementEnum(enumValue, enumType)
    unless enumValue == nil
      currentEnumIndex = (enumType.keys.index(enumValue))
    else
      currentEnumIndex = -1
    end
    
    maxEnumIndex = enumType.keys.count - 1
    newValue = (maxEnumIndex == currentEnumIndex ? enumValue.to_s : enumType.to_a[currentEnumIndex+1])
    return newValue[0]
  end

  def decrementEnum(enumValue, enumType) 
    currentEnumIndex = (enumType.keys.index(enumValue))
    minEnumIndex = 0
    newValue = (minEnumIndex == currentEnumIndex ? enumValue.to_s : enumType.to_a[currentEnumIndex-1])
    return newValue[0]
  end
  
  def is_sortable_column(column)
    column == sort_column
  end
  
  def sortable_title(column, title = nil)
    title ||= column.titleize
    direction = (is_sortable_column(column) && sort_direction == 'asc' ? 'desc' : 'asc')
    link_to title, { :sort => column, :direction => direction }
  end
  
  def sortable_class(column, asc_class = nil, desc_class = nil)
    asc_class ||= 'ascending'
    desc_class ||= 'descending'
    
    is_sortable_column(column) ? (sort_direction == 'asc' ? asc_class : desc_class) : ''
  end
  
  def sortable_header(column, title = nil, class_list = nil, asc_class = nil, desc_class = nil)
    title_text = sortable_title(column, title)
    css_class = sortable_class(column, asc_class, desc_class)
    
    '<th' + 
    (is_sortable_column(column) ? ' class = "' + (class_list.present? ? class_list + ' ' + css_class : css_class) + '"' : '') +
      '>' + 
      title_text + 
    '</th>'
  end
  
  def sortable_header_sui(column, title = nil)
    sortable_header(column, title, 'sorted')
  end

  # change the default link renderer for will_paginate
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge :renderer => PaginationHelper::SemanticLinkRenderer
    end
    super *[collection_or_options, options].compact
  end
  
  # Below code so we can embed a devise sign up or sign in form in any page
  
  def resource_class
    User
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
