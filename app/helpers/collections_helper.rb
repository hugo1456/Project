module CollectionsHelper

  def collection_wrap(content, n)
   truncate(sanitize(raw(content.split.map{ |s| collection_wrap_long_string(s) }.join(' '))), length: n, separator: ' ', escape: false)
  end

  private

    def collection_wrap_long_string(text, max_width = 18)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
                                  text.scan(regex).join(zero_width_space)
    end
end
