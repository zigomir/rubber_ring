module RubberRing
  class CmsController < RubberRingController
    include Build
    include Publish
    include Util

    before_action :get_options, :except => [:save]

    def save
      page = Util.save_page_content(params)
      expire_and_respond(page)
    end

    def remove
      page = Page.remove(@options, params[:key])
      expire_and_respond(page)
    end

    def save_template
      page = Page.save_or_update_templates(@options)
      expire_and_respond(page)
    end

    def add_template
      page = Page.add_template(@options)
      expire_and_respond(page)
    end

    def remove_template
      page = Page.remove_template(@options)
      expire_and_respond(page)
    end

  private

    def get_options
      @options = Util.get_options_from_params(params)
    end

  end
end
