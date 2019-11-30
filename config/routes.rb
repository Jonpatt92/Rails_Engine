Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/find',         to: 'find#show'
        get '/find_all',     to: 'find#index'
        get '/random',       to: 'random#show'
        get '/revenue',      to: 'revenue#show'
        get '/most_revenue', to: 'revenue#index'
        get '/:id/items',    to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
      end

      resources :merchants, only: [:index, :show]
    end
  end
end
