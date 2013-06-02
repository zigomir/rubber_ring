module RubberRing
  module CmsHelper

    def editable_field(tag, options = {}, page, &block)
      key = options[:key]
      content_value = nil
      content_value = page.content[key] unless page.content.nil?

      content_tag_options = {
        :class            => options[:class],
        :id               => options[:id]
      }

      if page and page.edit_mode?
        content_tag_options['data-cms']        = key
        content_tag_options['contenteditable'] = 'true'
      end

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
        :href      => href_attribute || options[:href]
      }
      content_tag_options['data-cms'] = key if page and page.edit_mode?

      content_value = capture(&block) if content_value.nil?
      return content_tag_options, content_value
    end

    def editable_image(options = {}, page)
      key = options[:key]
      image_source = nil
      image_source = page.content[key] unless page.content.nil?

      content_tag_options = {
        :class     => "rubber_ring_image #{options[:class]}",
        :src       => image_source || options[:src]
      }
      content_tag_options['data-cms'] = key if page and page.edit_mode?

      unless options[:width].nil?
        content_tag_options.merge!({width: options[:width]})
      end

      unless options[:height].nil?
        content_tag_options.merge!({height: options[:height]})
      end

      tag(:img, content_tag_options)
    end

    def template(templates, options = {}, page)
      page_templates = page.page_templates.where(key: options[:key])

      # if nothing is saved yet, use templates from helper defined in erb
      # convert array of hashes to open struct which will provide template and index methods like AR
      if page_templates.empty?
        page_templates = templates.inject([]) { |pt, t| pt << OpenStruct.new(t) }
        grouped_templates = page_templates
        from_db = false
      else
        grouped_templates = page_templates.group(:template)
        from_db = true
      end

      key = options[:key]
      concat(render 'rubber_ring/template_control', key: key, template_types: grouped_templates, from_db: from_db)

      content_tag_options = { class: "#{options[:wrap_class]}" }
      content_tag_options['data-cms'] = key if page and page.edit_mode?
      built_templates = build_templates(page_templates, page, key)

      concat(content_tag(options[:wrap_element], raw(built_templates), content_tag_options))
    end

    private

    def build_templates(page_templates, page, key)
      templates_concatenated = ''

      page_templates.each_with_index do |t, index|
        t.id = t.id.nil? ? index : t.id
        rendered_template = render "templates/#{t.template}", key_prefix: "#{t.id}_#{key}_#{t.template}"
        content_tag_options = {'class' => t.tclass}

        if page and page.edit_mode?
          content_tag_options['data-template'] = t.template
          content_tag_options['data-template-index'] = t.id
        end

        templates_concatenated += content_tag(t.element, rendered_template, content_tag_options)
      end

      templates_concatenated
    end

  end
end
