class SiteController < CmsController
  # this will output every page to public
  caches_page :home, :if => Proc.new { |c| c.request.params[:cache] == '1' }

  def home
  end
end
