module RubberRing
  class Page < ActiveRecord::Base
    attr_accessor :edit_mode, :title
    has_many :page_contents
    has_many :page_templates

    def self.save_or_update(options)
      page, page_content = get_page_and_content(options, :content)

      page_content.keys.each do |key|
        pc = RubberRing::PageContent.where('page_id = ? AND key = ?', page.id, key)
          .first_or_initialize()

        pc.update_attributes(
          key:   key,
          value: page_content[key],
          page:  page
        )

        pc.save
      end

      page
    end

    def self.save_or_update_templates(options)
      page, templates = get_page_and_content(options, :content)

      templates.keys.each do |key|
        templates[key].each do |template|
          template = template.last
          pt = RubberRing::PageTemplate
            .where('page_id = ? AND key = ? AND "index" = ?', page.id, key, template['index'])
            .first_or_initialize()

          pt.update_attributes(
            key:      key,
            index:    template['index'],
            template: template['template'],
            sort:     template['sort'],
            page:     page
          )

          pt.save
        end
      end

      page
    end

    def self.remove(options, key_to_remove)
      page = load_first_page(options)
      RubberRing::PageContent
        .where('page_id = ? AND key = ?', page.id, key_to_remove)
        .delete_all()
      page
    end

    def group_keys(group_key)
      return [] if content.nil?
      (content.select { |key, _| key.match(group_key) }).keys
    end

    def edit_mode?
      @edit_mode
    end

    # all page_contents as one hash
    def content
      result = {}
      page_contents.each do |page_content|
        result[page_content.key] = page_content.value
      end
      result
    end

    # def templates
    #   result = {}
    #   page_templates.each do |template|
    #     result[template.key] = template.value
    #   end
    #   result
    # end

    def title
      self.content['page_title'] unless self.content.nil?
    end

  private

    def self.load_first_page(options)
      where(controller: options[:controller], action: options[:action], locale: options[:locale]).first
    end

    def self.get_page_and_content(options, content_key)
      page = load_first_page(options)
      content = options[content_key]

      if page.nil?
        page = create(
          controller: options[:controller],
          action:     options[:action],
          locale:     options[:locale]
        )
      end

      return page, content
    end

  end
end
