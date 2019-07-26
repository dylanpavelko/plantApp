Rails.application.routes.draw do
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
