Rails.application.routes.draw do
  devise_for :users
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  resources :notes
  resources :ressources
  resources :dashboards do
    resources :transactions
    get '/charts/values', to: 'charts#values'
    get '/charts/pie', to: 'charts#pie'
    get '/charts/sparkline', to: 'charts#sparkline'
    resources :charts
  end
end
