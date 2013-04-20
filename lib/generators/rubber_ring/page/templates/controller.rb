class <%= class_name %>Controller < RubberRing::CmsController
<% actions.each do |action| -%>
  caches_page :<%= action %>, :if => Proc.new { |c| c.request.params[:cache] == '1' }
<% end -%>

<% actions.each do |action| -%>
  def <%= action %>
  end
<%= "\n" unless action == actions.last -%>
<% end -%>
end
