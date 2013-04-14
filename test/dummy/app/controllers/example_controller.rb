class ExampleController < RubberRing::CmsController
  # this will output every page to public; extract it to generator
  caches_page :page, :if => Proc.new { |c| c.request.params[:cache] == '1' }

  def page
  end
end
