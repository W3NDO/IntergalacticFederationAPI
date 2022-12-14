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

  post '/contracts/fulfill', to: "contracts#fulfill_contract"
  post '/contracts/:id/fulfill', to: "contracts#fulfill_contract"

  get '/reports', to: "reports#full_report"
  get '/reports/pilots', to: "reports#get_pilots_report"
  get '/reports/planets', to: "reports#get_planets_report"
end
