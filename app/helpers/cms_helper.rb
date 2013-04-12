module CmsHelper

  # it is important to capture and strip block before
  # when I was passing $block as last argument it would end like clutter because of whitespaces (indentation)
  # you add in ERB file inside this helper definition
  def editable_field(tag, options = {}, content, &block)
    content_value = nil

    unless content.nil?
      key = options[:key]
      content_value = content[key]
    end

    content_tag_options = {
      :class            => options[:class],
      :id               => options[:id],
      'data-cms'        => options[:key],
      'data-cms-group'  => options[:group] || '',
      'contenteditable' => 'true'
    }

    # if no content yet in database for current key
    if content_value.nil?
      content_value = capture(&block).strip
    else
      content_value = raw(content_value)
    end

    content_tag(tag, content_value, content_tag_options)
  end

  # default to 3 time repeat
  def duplicable_editable_field(tag, options = {}, content, &block)
    duplications = options[:duplications] || 3
    child_tag    = options[:child_tag] || 'div'

    content_tag(tag, {class: 'duplicable_holder'}) do
      duplications.times do |i|
        options[:key] = "#{options[:group]}_#{i}"
        element = editable_field(child_tag.to_sym, options, content, &block)
        concat(element)
      end
    end
  end

end
