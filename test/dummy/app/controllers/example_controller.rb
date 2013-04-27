class ExampleController < RubberRing::CmsController
  caches_page :page, :if => Proc.new { |c| c.request.params[:cache] == '1' }
  caches_page :page2, :if => Proc.new { |c| c.request.params[:cache] == '1' }

  def page
  end

  def page2
  end

  def form
    flash[:message] = params[:value]
    redirect_to root_path
  end
end
