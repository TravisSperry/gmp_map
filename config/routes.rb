Rails.application.routes.draw do
  resources :subscribers

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#map_display'

  get 'irl_gbr' => 'pages#irl_gbr'
  get 'irl_gbr_data' => 'pages#irl_gbr_data', :defaults => { :format => 'json' }
  get 'world_data' => 'pages#world_data', :defaults => { :format => 'json' }
  get 'coordinates' => 'pages#subscriber_coordinates', :defaults => { :format => 'json' }
  post 'new_subscriber' => 'subscribers#new_subscriber'
end
