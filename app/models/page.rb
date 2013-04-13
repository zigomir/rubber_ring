class Page < ActiveRecord::Base

  def self.save_or_update(options)
    page = where(controller: options[:controller],
                 action:     options[:action]).first

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

  # group key is prefix
  # example group key: blog_posts
  # real keys are then: blog_posts_0, blog_posts_1, blog_posts_3, ...
  # this method will match all keys which starts with blog_posts and count them
  def times_duplicable_key(group_key)
    (content.select { |key, _| key.match(group_key) }).keys.length
  end

end
