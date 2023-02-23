Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
        collection do
          get 'authenticate', to: 'authenticate'
        end
      end

      resources :bids, only: %i[index create]

      resources :items, only: %i[show create] do
        member do
          post 'buy', to: 'buy'
        end
      end
    end
  end
end
