RubberRing::Engine.routes.draw do

  get  '',       :to => 'sessions#new'
  get  'logout', :to => 'sessions#destroy', :as => 'logout'
  post 'login',  :to => 'sessions#create',  :as => 'login'

  get  'build',    :to => 'rubber_ring#build',   :as => 'build'
  get  'publish',  :to => 'rubber_ring#publish', :as => 'publish'

  post 'cms/save', :to => 'cms#save', :as => 'cms_save'
  post 'cms/remove/:key', :to => 'cms#remove', :as => 'cms_remove'
  post 'cms/save_template', :to => 'cms#save_template', :as => 'cms_save_template'
  post 'cms/add_template', :to => 'cms#add_template', :as => 'cms_add_template'
  post 'cms/remove_template', :to => 'cms#remove_template', :as => 'cms_remove_template'


  post 'cms/save_image', :to => 'attachments#save_image', :as => 'cms_save_image' # convert and set image to page content
  post 'cms/save_attachment', :to => 'attachments#save_attachment', :as => 'cms_save_attachment'

  post 'cms/attachments/add', :to => 'attachments#add', :as => 'cms_add_attachment'
  post 'cms/attachments/remove', :to => 'attachments#remove', :as => 'cms_remove_attachment'

end
