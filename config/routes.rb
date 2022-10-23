Rails.application.routes.draw do
  resources :financial_transactions, only: [:show, :create, :index]
  resources :planets, only: [:show, :index, :update]
  resources :contracts
  resources :ships
  resources :resources
  resources :pilots

  post '/travel', to: 'travel#create'
  post '/refill', to: 'financial_transactions#fuel_refill'
  
  post '/contracts/accept', to: "contracts#accept"
  post '/contracts/:id/accept', to: "contracts#accept"

  post '/contracts/fulfil', to: "contracts#fulfil_contract"
  post '/contracts/:id/fulfil', to: "contracts#fulfil_contract"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
