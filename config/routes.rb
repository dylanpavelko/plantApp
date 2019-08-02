Rails.application.routes.draw do
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
