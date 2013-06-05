class <%= class_name %>Controller < RubberRing::CmsController
  after_filter :cache_page, :if => Proc.new { |c| c.request.params[:cache] == '1' }
end
