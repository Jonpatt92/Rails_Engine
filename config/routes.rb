Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :merchants do
        ## Search ##
        get '/find',                    to: 'find#show'
        get '/find_all',                to: 'find#index'
        get '/random',                  to: 'random#show'

        ## Relationships ##
        get '/:id/items',               to: 'items#index'
        get '/:id/invoices',            to: 'invoices#index'

        ## Business Logic ##
        get '/revenue',                 to: 'total_revenue#show'
        get '/most_revenue',            to: 'most_revenue#index'
        get '/:id/favorite_customer',   to: 'favorite_customer#show'
      end

      namespace :items do
        ## Search ##
        get '/find',                    to: 'find#show'
        get '/find_all',                to: 'find#index'
        get '/random',                  to: 'random#show'

        ## Relationships ##
        get '/:id/merchant',            to: 'merchant#show'
        get '/:id/invoice_items',       to: 'invoice_items#index'

        ## Business Logic ##
        get '/most_revenue',            to: 'most_revenue#index'
        get '/:id/best_day',            to: 'best_day#show'
      end

      namespace :customers do
        ## Search ##
        get '/find',                    to: 'find#show'
        get '/find_all',                to: 'find#index'
        get '/random',                  to: 'random#show'

        ## Relationships ##
        get '/:id/invoices',            to: 'invoices#index'
        get '/:id/transactions',        to: 'transactions#index'

        ## Business Logic ##
        get '/:id/favorite_merchant',   to: 'favorite_merchant#show'
      end

      namespace :invoices do
        ## Search ##
        get '/find',                    to: 'find#show'
        get '/find_all',                to: 'find#index'
        get '/random',                  to: 'random#show'

        ## Relationships ##
        get '/:id/items',               to: 'items#index'
        get '/:id/invoice_items',       to: 'invoice_items#index'
        get '/:id/transactions',        to: 'transactions#index'
        get '/:id/customer',            to: 'customer#show'
        get '/:id/merchant',            to: 'merchant#show'
      end

      namespace :invoice_items do
        ## Search ##
        get '/find',                    to: 'find#show'
        get '/find_all',                to: 'find#index'
        get '/random',                  to: 'random#show'

        ## Relationships ##
        get '/:id/invoice',             to: 'invoice#show'
        get '/:id/item',                to: 'item#show'
      end

      namespace :transactions do
        ## Search ##
        get '/find',                    to: 'find#show'
        get '/find_all',                to: 'find#index'
        get '/random',                  to: 'random#show'

        ## Relationships ##
        get '/:id/invoice',             to: 'invoice#show'
      end

      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
