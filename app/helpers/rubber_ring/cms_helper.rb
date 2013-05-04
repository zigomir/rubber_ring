module RubberRing
  module CmsHelper

    def editable_field(tag, options = {}, page, &block)
      key = options[:key]
      content_value = nil
      content_value = page.content[key] unless page.content.nil?

      content_tag_options = {
        :class            => options[:class],
        :id               => options[:id],
        'data-cms'        => key,
        'data-cms-group'  => options[:group] || ''
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

    def attachment(options = {}, page, &block)
      key = options[:key]
      attachment_href = nil
      attachment_href = page.content[key] unless page.content.nil?

      content_tag_options = {
        :class     => 'rubber_ring_attachment',
        :id        => options[:id],
        :href      => attachment_href || options[:href],
        'data-cms' => key,
        'download' => ''
      }
      content_value = capture(&block)

      content_tag(:a, raw(content_value), content_tag_options)
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
        concat(render "templates/#{key}", index: i)
      end
    end

  end
end
