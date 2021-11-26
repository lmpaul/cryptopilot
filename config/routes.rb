Rails.application.routes.draw do
  devise_for :users
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  resources :notes
  resources :dashboards do
    resources :transactions
    resources :charts, only: [:index]
  end
  namespace :api do
      resources :values
    end
end
