RubberRing::Engine.routes.draw do

  get '',       :to => 'sessions#new'
  post 'login', :to => 'sessions#create', :as => 'login'

  post 'cms/save',         :to => 'cms#save',   :as => 'cms_save'
  post 'cms/remove/:key',  :to => 'cms#remove', :as => 'cms_remove'

  post 'cms/save_image',   :to => 'images#save_image',   :as => 'cms_save_image' # convert and set image to page content
  post 'cms/image/add',    :to => 'images#image_add',    :as => 'cms_image_add'  # upload image
  post 'cms/image/remove', :to => 'images#image_remove', :as => 'cms_image_remove'

end
