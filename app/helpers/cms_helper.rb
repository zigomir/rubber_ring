module CmsHelper

  def editable_field(tag, options = {}, content, &block)
    content_value = nil

    unless content.nil?
      key = options[:key]
      content_value = content[key]
    end

    if content_value.nil?
      content_tag(tag,
                  :class          => options[:class],
                  :id             => options[:id],
                  'data-cms'      => options[:key],
                  'data-cms-type' => options[:type],
                  &block
      )
    else
      content_tag(tag,
                  content_value,
                  :class          => options[:class],
                  :id             => options[:id],
                  'data-cms'      => options[:key],
                  'data-cms-type' => options[:type],
      )
    end
  end

end
