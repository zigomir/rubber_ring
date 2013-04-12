module CmsHelper

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
    content_value = capture(&block) if content_value.nil?

    content_tag(tag, raw(content_value), content_tag_options)
  end

  def duplicable_editable_field(tag, options = {}, content, &block)
    # defaults
    duplications = options[:duplications] || 3
    child_tag    = options[:child_tag] || (tag == :ul || tag == :ol) ? 'li' : 'div'

    content_tag(tag, {class: 'duplicable_holder'}) do
      duplications.times do |i|
        options[:key] = "#{options[:group]}_#{i}"
        element = editable_field(child_tag.to_sym, options, content, &block)
        concat(element)
      end
    end
  end

end
