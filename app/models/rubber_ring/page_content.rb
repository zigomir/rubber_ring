module RubberRing
  class PageContent < ActiveRecord::Base
    belongs_to :page
    serialize :value

    def self.add_page_content(page, page_content, page_content_key)
      RubberRing::PageContent.create(
        key:   page_content_key,
        value: page_content[page_content_key],
        page:  page
      )
    end

    def self.update_page_content(page, page_content, page_content_key)
      pc = RubberRing::PageContent.where('page_id = ? AND key = ?', page.id, page_content_key).first
      pc.value = page_content[page_content_key]
      pc.save
    end

    def self.remove_page_content(page, key_to_remove)
      RubberRing::PageContent.where('page_id = ? AND key = ?', page.id, key_to_remove)
        .delete_all()
    end

  end
end
