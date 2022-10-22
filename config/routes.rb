Rails.application.routes.draw do
  resources :financial_transactions, only: [:show, :create, :index]
  resources :planets, only: [:show, :index, :update]
  resources :contracts
  resources :ships
  resources :resources
  resources :pilots

  post '/travel', to: 'travel#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
