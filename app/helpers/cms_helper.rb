module CmsHelper

  def editable_field(tag, options = {}, content, &block)
    content_value = nil

    unless content.nil?
      key = options[:key]
      content_value = content[key]
    end

    if content_value.nil?
      # there is so important to capture and strip block before
      # when I was passing $block as last argument it would end like clutter because of whitespaces (indentation)
      # you add in ERB file inside this helper definition
      content_tag(tag,
                  capture(&block).strip,
                  :class            => options[:class],
                  :id               => options[:id],
                  'data-cms'        => options[:key],
                  'data-cms-type'   => options[:type],
                  'contenteditable' => 'true'
      )
    else
      content_tag(tag,
                  raw(content_value),
                  :class            => options[:class],
                  :id               => options[:id],
                  'data-cms'        => options[:key],
                  'data-cms-type'   => options[:type],
                  'contenteditable' => 'true'
      )
    end
  end

end
