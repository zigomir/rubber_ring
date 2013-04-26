module RubberRing
  class CmsController < ActionController::Base
    include Build
    include Publish
    include Util

    layout 'rubber_ring/application'
    before_action :load_page_content
    before_filter :admin?, :cache?, :publish? # check if admin before cache

    def load_page_content
      page = Page.where(controller: params[:controller],
                        action:     params[:action])

      @page = page.empty? ? Page.new : page.first
      @page.edit_mode = true
      @images = Util.load_images_for_page(params)
    end

    def save
      page = Util.save_page_content(params)

      expire_page(params[:page_path])
      render :json => { controller: page.controller, action: page.action, content: page.content }
    end

    def remove
      options = Util.get_options_from_params(params)
      page = Page.remove(options, params[:key_to_remove])
      expire_page(params[:page_path])

      render :json => { controller: page.controller, action: page.action, content: page.content }
    end

  private

    def admin?
      if session[:password] == RubberRing.admin_password
        @admin = true
        @page.edit_mode = true
      else
        @admin = false
        @page.edit_mode = false
      end
    end

    def cache?
      if params[:cache] == '1' and params[:publish].nil?
        disable_edit_mode
        Thread::new{
          Build.assets!
        }
      end
    end

    def publish?
      if params[:publish] == '1' and params[:cache] == '1'
        disable_edit_mode
        Thread::new{
          Build.assets!
          Publish.assets!
        }
      end
    end

    def disable_edit_mode
      @page_caching = true
      @page.edit_mode = false
    end

  end
end
