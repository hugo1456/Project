module ApplicationHelper

  #Return the full title on a per-page basis
  def full_title(page_title)
    base_title = " Project"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
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

  def resource_class
    devise_mapping.to
  end
  
  def wrap(content, n)
    truncate(sanitize(strip_tags(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))), length: n, separator: ' ', escape: false)
  end
  
  private
  
    def wrap_long_string(text, max_width = 30)
     zero_width_space = "&#8203;"
     regex = /.{1,#{max_width}}/
     (text.length < max_width) ? text : 
                              text.scan(regex).join(zero_width_space)
   end
end
