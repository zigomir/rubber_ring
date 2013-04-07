class ExampleController < RubberRing::CmsController
  # this will output every page to public
  # set action names
  caches_page :page, :if => Proc.new { |c| c.request.params[:cache] == '1' }

  def page
    # set your layout, copy it from application.html.erb
    render :layout => 'example/layout'
  end
end
