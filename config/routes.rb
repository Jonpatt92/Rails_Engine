Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/find',                  to: 'find#show'
        get '/find_all',              to: 'find#index'
        get '/random',                to: 'random#show'
        get '/revenue',               to: 'total_revenue#show'
        get '/most_revenue',          to: 'most_revenue#index'
        get '/:id/favorite_customer', to: 'customer#show'
        get '/:id/items',             to: 'items#index'
        get '/:id/invoices',          to: 'invoices#index'
      end

      resources :merchants, only: [:index, :show]
    end
  end
end
