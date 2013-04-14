Rails.application.routes.draw do
  mount RubberRing::Engine => '/rubber_ring', :as => 'rubber_ring'
  root to: 'example#page'
end
