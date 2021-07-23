Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants#find'
      get 'items/find_all', to: 'items#find_all'

      resources :items, except: [:new, :edit] do
        resources :merchant, module: 'items', only: [:index]
      end

      resources :merchants, only: [:index, :show] do
        resources :items, module: 'merchants', only: [:index]
      end

      scope :revenue do
        get '/merchants/:id', to: 'revenue#merchant_total_revenue'
        get '/merchants', to: 'revenue#merchants_most_revenue'
        get '/items', to: 'revenue#items_revenue_ranked'
        get '/unshipped', to: 'revenue#unshipped_potential'
      end
    end
  end
end
