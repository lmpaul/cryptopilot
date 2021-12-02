Rails.application.routes.draw do
  devise_for :users
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get '/team', to: "pages#team", as: :team
  resources :notes

  resources :dashboards do
    resources :transactions, only: [:index, :edit, :update, :new, :create, :destroy]
    get '/charts/values', to: 'charts#values'
    get '/charts/pie', to: 'charts#pie'
    get '/charts/sparkline', to: 'charts#sparkline'
  end
  resources :ressources, only: [:index, :edit, :update]do
    resources :votes
  end
  get '/ressources/exchanges', to: 'ressources#exchanges', as: :exchanges
  get '/ressources/wallets', to: 'ressources#wallets', as: :wallets
  get '/ressources/youtube', to: 'ressources#youtube', as: :youtube

end
