class ExampleController < RubberRing::CmsController
  after_filter :cache_page, :if => Proc.new { |c| c.request.params[:cache] == '1' }
end
