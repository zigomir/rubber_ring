class Page < ActiveRecord::Base

  def self.save_or_update(options)
    page = where(controller: options[:controller],
                 action:     options[:action]).first

    #key   = options[:key]
    #value = options[:value]

    if page.nil?
      new_page = create(
        controller: options[:controller],
        action:     options[:action],
        content:    options[:content]
      )
      new_page
    else
      page.content = (page.content || {}).merge(options[:content])
      page.save
      page
    end
  end

  def group_key?(key)
    true if content[key].class == Hash
  end

  def times_duplicable_key(key)
    group_key?(key) ? content[key].keys.length : 0
  end

end
