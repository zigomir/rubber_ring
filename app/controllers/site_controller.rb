class SiteController < CmsLoadController
  # this will output every page to public
  caches_page :home

  def home
  end
end
