module RubberRing
  module CmsHelper

    def editable_field(tag, options = {}, page, &block)
      key = options[:key]
      content_value = nil
      content_value = page.content[key] unless page.content.nil?

      content_tag_options = {
        :class            => options[:class],
        :id               => options[:id],
        'data-cms'        => options[:key],
        'data-cms-group'  => options[:group] || ''
      }
      content_tag_options['contenteditable'] = 'true' if page and page.edit_mode?

      # if no content passed from @content (view - controller - model)
      # this means it is not yet in database and we will create tag with
      # content which is defined in a block of this editable_field helper
      content_value = capture(&block) if content_value.nil?

      content_tag(tag, raw(content_value), content_tag_options)
    end

    def editable_image(options = {}, page)
      key = options[:key]
      image_source = nil
      image_source = page.content[key] unless page.content.nil?

      content_tag_options = {
        :class     => 'rubber_ring_image',
        :src       => image_source || options[:src],
        'data-cms' => options[:key]
      }
      content_tag(:img, nil, content_tag_options)
    end

    def duplicable_editable_field(tag, options = {}, page, &block)
      # defaults
      # add duplicable class
      classes   = options[:class].nil? || options[:class].length == 0 ? 'duplicable' : "#{options[:class]} duplicable"
      options   = options.merge({class: classes})
      child_tag = options[:child_tag] || (tag == :ul || tag == :ol) ? 'li' : 'div'

      group_keys = []
      group_keys = page.group_keys(options[:group]) unless page.nil?
      group_keys << "#{options[:group]}_0" if group_keys.empty? # at least one

      content_tag(tag, {class: 'duplicable_holder'}) do
        group_keys.each do |group_key|
          options[:key] = group_key
          element = editable_field(child_tag.to_sym, options, page, &block)
          concat(element)
        end
      end
    end

  end
end
