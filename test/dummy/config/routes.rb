Rails.application.routes.draw do
  mount RubberRing::Engine => '/rubber_ring', :as => 'rubber_ring'

  root to: 'example#page'
  get 'page2', to: 'example#page2', as: 'page2'
end
