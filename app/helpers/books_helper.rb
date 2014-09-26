module BooksHelper
  
  def book_wrap(content, n)
   truncate(sanitize(strip_tags(raw(content.split.map{ |s| book_wrap_long_string(s) }.join(' ')))), length: n, separator: ' ', escape: false)
  end

  private
  
    def book_wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
                                  text.scan(regex).join(zero_width_space)
    end
end