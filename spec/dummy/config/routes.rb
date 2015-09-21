Rails.application.routes.draw do

  mount ProducedItemWarehousex::Engine => "/produced_item_warehousex"
  mount Authentify::Engine => "/authentify"
  mount Commonx::Engine => "/commonx"
  mount MfgBatchx::Engine => "/mfg_batchx"
  mount JobshopRfqx::Engine => '/jobshop_rfqx'
  mount JobshopQuotex::Engine => '/jobshop_quotex'
  mount Kustomerx::Engine => '/kustomerx'
  mount MfgOrderx::Engine => '/orderx'
  mount MfgProcessx::Engine => '/mfg_processx'
  mount EventTaskx::Engine => '/event_taskx'
  mount Searchx::Engine => '/searchx'
  mount StateMachineLogx::Engine => '/sm_log'
  mount BizWorkflowx::Engine => '/biz_wf'
  
  
  root :to => "authentify/sessions#new"
  get '/signin',  :to => 'authentify/sessions#new'
  get '/signout', :to => 'authentify/sessions#destroy'
  get '/user_menus', :to => 'user_menus#index'
  get '/view_handler', :to => 'authentify/application#view_handler'
end
