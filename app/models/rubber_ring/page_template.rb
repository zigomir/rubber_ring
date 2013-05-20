module RubberRing
  class PageTemplate < ActiveRecord::Base
    belongs_to :page

    # def self.add_page_template(page, template, key, index)
    #   RubberRing::PageTemplate.create(
    #     key:      key,
    #     index:    index,
    #     template: template,
    #     page:     page
    #   )
    # end

    # def self.update_page_template(page, template, key, index)
    #   pc = RubberRing::PageTemplate.where('page_id = ? AND key = ?', page.id, key).first
    #   pc.template = template
    #   pc.save
    # end

    # def self.remove_page_content(page, key_to_remove)
    #   RubberRing::PageContent.where('page_id = ? AND key = ?', page.id, key_to_remove)
    #     .delete_all()
    # end

  end
end
