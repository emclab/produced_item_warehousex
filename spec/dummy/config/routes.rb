Rails.application.routes.draw do

  mount ProducedItemWarehousex::Engine => "/produced_item_warehousex"
  mount Authentify::Engine => "/authentify"
  mount Commonx::Engine => "/commonx"
  #mount Kustomerx::Engine => '/kustomerx'
  mount ProductionOrderx::Engine => '/order'
  #mount Searchx::Engine => '/searchx'
  #mount StateMachineLogx::Engine => '/sm_log'
  #mount BizWorkflowx::Engine => '/biz_wf'
  mount Messagingx::Engine => '/msg'
  
  
  root :to => "authentify/sessions#new"
  get '/signin',  :to => 'authentify/sessions#new'
  get '/signout', :to => 'authentify/sessions#destroy'
  get '/user_menus', :to => 'user_menus#index'
  get '/view_handler', :to => 'authentify/application#view_handler'
end
