module RubberRing
  class PageContent < ActiveRecord::Base
    belongs_to :page

    def self.add_new_page_content(page, page_content, page_content_key)
      RubberRing::PageContent.create(
          key:   page_content_key,
          value: page_content[page_content_key],
          page:  page
      )
    end

    def self.update_page_content(page, page_content, page_content_key)
      RubberRing::PageContent.where('page_id = ? AND key = ?', page.id, page_content_key)
      .update_all("value = '#{page_content[page_content_key]}'")
    end

    def self.remove_page_content(page, key_to_remove)
      RubberRing::PageContent.where('page_id = ? AND key = ?', page.id, key_to_remove)
      .delete_all()
    end

  end
end
