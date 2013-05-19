module RubberRing
  module CmsHelper

    def editable_field(tag, options = {}, page, &block)
      key = options[:key]
      content_value = nil
      content_value = page.content[key] unless page.content.nil?

      content_tag_options = {
        :class            => options[:class],
        :id               => options[:id],
        'data-cms'        => key
      }
      content_tag_options['contenteditable'] = 'true' if page and page.edit_mode?

      # if no content passed from @content (view - controller - model)
      # this means it is not yet in database and we will create tag with
      # content which is defined in a block of this editable_field helper
      content_value = capture(&block) if content_value.nil?

      content_tag(tag, raw(content_value), content_tag_options)
    end

    def title(page, &block)
      editable_field(:span, {key: 'page_title'}, page, &block)
    end

    def editable_link(options = {}, page, &block)
      content_tag_options, content_value = compose_link(block, options, page)
      content_tag_options['contenteditable'] = 'true' if page and page.edit_mode?
      content_tag(:a, raw(content_value), content_tag_options)
    end

    def compose_link(block, options, page)
      key = options[:key]
      content_value = nil
      content_value = page.content[key] unless page.content.nil?
      href_attribute = nil
      href_attribute = page.content["#{key}_href"] unless page.content.nil?

      content_tag_options = {
        :class     => options[:class],
        :id        => options[:id],
        :href      => href_attribute || options[:href],
        'data-cms' => key
      }

      content_value = capture(&block) if content_value.nil?
      return content_tag_options, content_value
    end

    def editable_image(options = {}, page)
      key = options[:key]
      image_source = nil
      image_source = page.content[key] unless page.content.nil?

      content_tag_options = {
        :class     => "rubber_ring_image #{options[:class]}",
        :src       => image_source || options[:src],
        'data-cms' => options[:key]
      }

      unless options[:width].nil?
        content_tag_options.merge!({width: options[:width]})
      end

      unless options[:height].nil?
        content_tag_options.merge!({height: options[:height]})
      end

      tag(:img, content_tag_options)
    end

    def repeat_template(key, page)
      concat(render 'rubber_ring/repeat_control', key: key)

      repeat = '1'
      repeat = page.content[key] unless page.content.nil?
      repeat = 1 if repeat.nil? or repeat == 0

      repeat.to_i.times do |i|
        concat(render "templates/#{key}", key_prefix: "#{i}_#{key}")
      end
    end

    def template(templates, options = {}, page)
      key = options[:key]
      templates_from_content = page.content[key] unless page.content.nil?
      # if nothing is saved yet
      templates_from_content = templates if templates_from_content.nil?

      concat(render 'rubber_ring/template_control', key: key, templates: templates_from_content)

      templates_from_content.each_with_index do |template, i|
        concat(render "templates/#{template}", key_prefix: "#{i}_#{key}_#{template}")
      end
    end

  end
end
