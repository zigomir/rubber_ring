RubberRing::Engine.routes.draw do

  get '/admin',            :to => 'sessions#new'
  post '/admin/login',     :to => 'sessions#create', :as => 'login'

  post 'cms/save',         :to => 'cms#save',         :as => 'cms_save'
  post 'cms/remove/:key',  :to => 'cms#remove',       :as => 'cms_remove'
  post 'cms/image/add',    :to => 'cms#image_add',    :as => 'cms_image_add'
  post 'cms/image/remove', :to => 'cms#image_remove', :as => 'cms_image_remove'

end
