Rails.application.routes.draw do
  # TODO add this to readme
  mount RubberRing::Engine => '/rubber_ring', :as => 'rubber_ring'

  # You need to name this
  root to: 'example#page', :as => 'example_page'
end
