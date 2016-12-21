module PaginationHelper
  class SemanticLinkRenderer < WillPaginate::ActionView::LinkRenderer
    
    def to_html
      #@options[:class] = (defined? options[:class]) ? options[:class] : 'ui borderless pagination menu'
      @options[:class] = 'ui borderless pagination menu'
      @options[:item_class] = (defined? options[:item_class]) ? options[:item_class] : 'item'
      @options[:active_item_class] = (defined? options[:active_item_class]) ? options[:active_item_class] : 'active'
      @options[:disabled_item_class] = (defined? options[:disabled_item_class]) ? options[:disabled_item_class] : 'disabled'
      
      super
    end
    
    protected
      def page_number(page)      
        unless page == current_page
          link(page, page, :rel => rel_value(page), :class => @options[:item_class])
        else
          tag(:em, page, :class => @options[:active_item_class] + ' ' + @options[:item_class])
        end
      end
    
      def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        previous_or_next_page(num, @options[:previous_label], @options[:item_class])
      end
      
      def next_page
        num = @collection.current_page < total_pages && @collection.current_page + 1
        previous_or_next_page(num, @options[:next_label], @options[:item_class])
      end
    
      def previous_or_next_page(page, text, classname)
        if page
          link(text, page, :class => classname)
        else
          tag(:span, text, :class => classname + ' ' + @options[:disabled_item_class])
        end
      end
  end
end