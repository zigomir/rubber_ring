module Admin::CmsHelper

  def editable_field(tag, options = {}, content, &block)
    key = [params[:controller], params[:action], options[:key]].join('_').to_sym
    content_value = content[key]

    if content_value.nil?
      content_tag(tag,
                  :class          => options[:class],
                  :id             => options[:id],
                  'data-cms'      => options[:key],
                  'data-cms-type' => options[:type],
                  &block
      )
    else
      content_tag(tag,
                  content_value,
                  :class          => options[:class],
                  :id             => options[:id],
                  'data-cms'      => options[:key],
                  'data-cms-type' => options[:type],
      )
    end
  end

end
