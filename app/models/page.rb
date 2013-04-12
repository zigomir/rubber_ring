class Page < ActiveRecord::Base

  def self.save_or_update(options)
    page = where(controller: options[:controller],
                 action:     options[:action]).first

    key   = options[:key]
    value = options[:value]
    #times = options[:]

    if page.nil?
      new_page = create(
        controller: options[:controller],
        action:     options[:action],
        content:    {key => value}
      )
      new_page
    else
      page.content = (page.content || {}).merge({key => value})
      page.save
      page
    end
  end

end
