# TODO this should be generated with generator

class SiteController < RubberRing::CmsController
  # this will output home page to public/build
  caches_page :home, :if => Proc.new { |c| c.request.params[:cache] == '1' }

  def home
    render :layout => 'site/layout'
  end
end
