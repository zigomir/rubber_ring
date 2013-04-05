class Page < ActiveRecord::Base

  def self.save_or_update(options)
    page = where(controller: options[:controller],
                 action:     options[:action]).first

    if page.nil?
      new_page = create(
        controller: params[:controller],
        action:     params[:action],
        content:    {options[:key] => options[:value]}
      )
      new_page
    else
      page.content = (page.content || {}).merge({options[:key] => options[:value]})
      page.save
      page
    end
  end

end
