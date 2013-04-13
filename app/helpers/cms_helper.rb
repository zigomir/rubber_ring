module CmsHelper

  def editable_field(tag, options = {}, page, &block)
    content_value = nil

    unless page.content.nil?
      key = options[:key]
      content_value = page.content[key]
    end

    content_tag_options = {
      :class            => options[:class],
      :id               => options[:id],
      'data-cms'        => options[:key],
      'data-cms-group'  => options[:group] || '',
      'contenteditable' => 'true'
    }

    # if no content passed from @content (view - controller - model)
    # this means it is not yet in database and we will create tag with
    # content which is defined in a block of this editable_field helper
    content_value = capture(&block) if content_value.nil?

    content_tag(tag, raw(content_value), content_tag_options)
  end

  # TODO
  def duplicable_editable_field(tag, options = {}, page, &block)
    # defaults
    duplications = options[:duplications] || page.times_duplicable_key(options[:group])
    child_tag    = options[:child_tag]    || (tag == :ul || tag == :ol) ? 'li' : 'div'

    content_tag(tag, {class: 'duplicable_holder'}) do
      duplications.times do |i|
        options[:key] = "#{options[:group]}_#{i}"
        element = editable_field(child_tag.to_sym, options, page, &block)
        concat(element)
      end
    end
  end

end
