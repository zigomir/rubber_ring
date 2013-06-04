module RubberRing
  class CmsController < RubberRingController
    include Build
    include Publish
    include Util
    #require CmsHelper

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
      page, new_pt = Page.add_template(@options)

      # TODO move to same method as for cms_helper
      key_prefix = "#{new_pt.id}_#{new_pt.key}_#{new_pt.template}"
      template = render_to_string :partial => "templates/#{new_pt.template}",
                                  :layout => false,
                                  :locals => {:page => page, :key_prefix => key_prefix}

      content_tag_options = {
        'class'               => new_pt.tclass,
        'data-template-index' => new_pt.id,
        'data-template'       => new_pt.template
      }

      response = view_context.content_tag(new_pt.element, view_context.raw(template), content_tag_options)

      expire_page(params[:page_path])
      render :json => {new_template: response}
    end

    def remove_template
      page = Page.remove_template(@options)
      # TODO try to return HTML for templates here
      expire_and_respond(page)
    end

  private

    def get_options
      @options = Util.get_options_from_params(params)
    end

  end
end
