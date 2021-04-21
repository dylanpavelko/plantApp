Rails.application.routes.draw do
  resources :weather_averages
  resources :growth_observations
  resources :bbch_stages
  resources :bbch_profiles
  resources :wishlists
  resources :weather_records
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

    get 'home/index'
    post 'user_token' => 'user_token#create'
    resources :users
    resources :water_records
    resources :plant_instances
    resources :locations
    resources :high_level_locations
    resources :cultivators
    resources :common_names
    resources :plants
    resources :varieties
    resources :species
    resources :genus
    resources :families
    resources :orders
    resources :plant_classes
    resources :divisions
    resources :kingdoms
    get '/search', to: 'search#index'
    get '/my_plants', to: 'plant_instances#my_plants'
    post '/add_water_records', to: 'water_records#add_water_records'
    post '/add_to_wishlist', to: 'wishlists#add_to_wishlist'
    post '/get_new_weather_records', to: 'weather_records#get_new_weather_records'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  
  
    resources :users
    resources :sessions, only: [:new, :create, :destroy]
    get '/signup', to: 'users#new', as: 'signup'
    get '/login', to: 'sessions#new', as: 'login'
    get '/logout', to: 'sessions#destroy', as: 'logout'
    
    root 'home#index'
end
