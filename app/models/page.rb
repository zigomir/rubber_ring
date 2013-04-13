class Page < ActiveRecord::Base

  def self.save_or_update(options)
    page = load_first_page(options)

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

  def self.remove(options, key_to_remove)
    page = load_first_page(options)
    page.content = (page.content || {}).except(key_to_remove)
    page.save
    page
  end

  # group key is prefix
  # example group key: blog_posts
  # real keys are then: blog_posts_0, blog_posts_1, blog_posts_3, ...
  # this method will match all keys which starts with blog_posts and count them
  def times_duplicable_key(group_key)
    (content.select { |key, _| key.match(group_key) }).keys.length
  end

  private

  def self.load_first_page(options)
    where(controller: options[:controller], action: options[:action]).first
  end

end
