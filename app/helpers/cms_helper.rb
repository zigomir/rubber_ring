module CmsHelper

  def editable_field(tag, options = {}, page, &block)
    content_value = nil

    unless page.nil?
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

  def editable_image(options = {}, page)
    content_tag_options = {
      :class     => 'rr_uploaded_image',
      :src       => options[:src],
      'data-cms' => options[:key]
    }
    #options = options.merge({class: 'rr_uploaded_image'})
    #editable_field(:img, options, page)
    #image_tag()
    content_tag(:img, nil, content_tag_options)
  end

  def duplicable_editable_field(tag, options = {}, page, &block)
    # defaults
    # add duplicable class
    classes      = options[:class].nil? || options[:class].length == 0 ? 'duplicable' : "#{options[:class]} duplicable"
    options      = options.merge({class: classes})
    child_tag    = options[:child_tag] || (tag == :ul || tag == :ol) ? 'li' : 'div'

    duplications = 1
    duplications = page.times_duplicable_key(options[:group]) unless page.nil?
    duplications = 1 if duplications == 0 # at least one

    content_tag(tag, {class: 'duplicable_holder'}) do
      duplications.times do |i|
        options[:key] = "#{options[:group]}_#{i}"
        element = editable_field(child_tag.to_sym, options, page, &block)
        concat(element)
      end
    end
  end

end
