module RubberRing
  class Page < ActiveRecord::Base
    attr_accessor :edit_mode, :title
    has_many :page_contents

    def self.save_or_update(options)
      page = load_first_page(options)
      page_content = options[:content]

      if page.nil?
        page = create(
          controller: options[:controller],
          action:     options[:action],
          locale:     options[:locale]
        )
      end

      options[:content].keys.each do |key|
        if page and page.content[key].nil?
          RubberRing::PageContent.add_page_content(page, page_content, key)
        else
          RubberRing::PageContent.update_page_content(page, page_content, key)
        end
      end

      page
    end

    def self.remove(options, key_to_remove)
      page = load_first_page(options)
      RubberRing::PageContent.remove_page_content(page, key_to_remove)
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

    def title
      self.content['page_title'] unless self.content.nil?
    end

  private

    def self.load_first_page(options)
      where(controller: options[:controller], action: options[:action], locale: options[:locale]).first
    end

  end
end
