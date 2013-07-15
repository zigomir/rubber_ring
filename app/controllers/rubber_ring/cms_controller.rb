module RubberRing
  class CmsController < RubberRingController
    include Build
    include Publish
    include Util

    before_filter :get_options, :except => [:save]

    def save
      page = Util.save_page_content(params)
      respond(page)
    end

    def remove
      page = Page.remove(@options, params[:key])
      respond(page)
    end

    def save_template
      page = Page.save_or_update_templates(@options)
      respond(page)
    end

    def add_template
      page, new_pt = Page.add_template(@options)

      key_prefix = view_context.build_key_prefix(new_pt, new_pt.key)
      template = render_to_string :partial => "templates/#{new_pt.template}",
                                  :layout => false,
                                  :locals => {:page => page, :key_prefix => key_prefix}

      content_tag_options = {
        'class'               => new_pt.tclass,
        'data-template-index' => new_pt.id,
        'data-template'       => new_pt.template
      }

      response = view_context.content_tag(new_pt.element, view_context.raw(template), content_tag_options)

      render :json => {new_template: response}
    end

    def remove_template
      page = Page.remove_template(@options)
      respond(page)
    end

  private

    def get_options
      @options = Util.get_options_from_params(params)
    end

  end
end
