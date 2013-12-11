module RubberRing
  class RubberRingController < ActionController::Base
    layout 'rubber_ring/layout'

    before_action :load_page_content, :set_locale
    before_filter :admin?

    def load_page_content
      page = Page.where(
        controller: params[:controller],
        action:     params[:action],
        locale:     params[:locale] || I18n.default_locale.to_s
      )

      @page = page.empty? ? Page.new : page.first
      @page.edit_mode = true
      @images, @attachments = Util.load_attachments_page(params)
    end

    def build
      @@thread = Build.run!(request)
    end

    # Check if build has finished
    def check
      render json: !@@thread.alive?
    end

    def publish
      begin
        Publish.assets!
      rescue Errno::EACCES
        flash.now[:error] =
          'Rubber Ring is trying to copy files on to path which is not writable.
           Please tell developers to check publish.yml file.'
      end
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
      @locale = I18n.locale.to_s
    end

    def respond(page)
      render :json => {controller: page.controller, action: page.action, content: page.content}
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
  end
end
