module RubberRing
  class Page < ActiveRecord::Base
    attr_accessor :edit_mode, :title

    def self.save_or_update(options)
      page = load_first_page(options)

      if page.nil?
        new_page = create(
          controller: options[:controller],
          action:     options[:action],
          content:    options[:content]
        )
        new_page
      else
        page.content = (page.content || {}).merge(options[:content])
        page.save
        page
      end
    end

    def self.remove(options, key_to_remove)
      page = load_first_page(options)
      page.content = (page.content || {}).except(key_to_remove)
      page.save
      page
    end

    def group_keys(group_key)
      return [] if content.nil?
      (content.select { |key, _| key.match(group_key) }).keys
    end

    def edit_mode?
      @edit_mode
    end

    def title
      self.content['page_title'] unless self.content.nil?
    end

  private

    def self.load_first_page(options)
      where(controller: options[:controller], action: options[:action]).first
    end

  end
end
