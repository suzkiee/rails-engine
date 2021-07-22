Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants/search#find'
      get 'items/find_all', to: 'items/search#find_all'

      resources :items, except: [:new, :edit] do
        resources :merchant, module: 'items', only: [:index]
      end

      resources :merchants, only: [:index, :show] do
        resources :items, module: 'merchants', only: [:index]
      end
      
    end
  end
end
