ProducedItemWarehousex::Engine.routes.draw do
  resources :items
  resources :checkouts
  
  root :to => 'items#index'
end
