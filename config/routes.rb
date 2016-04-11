Rails.application.routes.draw do
  resources :subscribers

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#map_display'

  # Example of regular route:
  get 'us' => 'pages#us', :defaults => { :format => 'json' }
  get 'coordinates' => 'pages#subscriber_coordinates', :defaults => { :format => 'json' }
  get 'new_subscriber' => 'new_subscriber#subscribers'
end
