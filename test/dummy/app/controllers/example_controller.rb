class ExampleController < RubberRing::CmsController
  caches_page :page, :if => Proc.new { |c| c.request.params[:cache] == '1' }

  def page
  end
end
