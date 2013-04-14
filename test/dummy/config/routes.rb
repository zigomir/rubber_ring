Rails.application.routes.draw do
  # TODO add this to readme
  mount RubberRing::Engine => '/rubber_ring', :as => 'rubber_ring'
  root to: 'example#page'
end
