RubberRing::Engine.routes.draw do

  get  '',       :to => 'sessions#new'
  get  'logout', :to => 'sessions#destroy', :as => 'logout'
  post 'login',  :to => 'sessions#create',  :as => 'login'

  post 'cms/save',          :to => 'cms#save',          :as => 'cms_save'
  post 'cms/save_template', :to => 'cms#save_template', :as => 'cms_save_template'
  post 'cms/remove/:key',   :to => 'cms#remove',        :as => 'cms_remove'


  post 'cms/save_image',      :to => 'attachments#save_image',      :as => 'cms_save_image' # convert and set image to page content
  post 'cms/save_attachment', :to => 'attachments#save_attachment', :as => 'cms_save_attachment'

  post 'cms/attachments/add',    :to => 'attachments#add',    :as => 'cms_add_attachment'
  post 'cms/attachments/remove', :to => 'attachments#remove', :as => 'cms_remove_attachment'

end
