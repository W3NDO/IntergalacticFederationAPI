Rails.application.routes.draw do
  resources :contracts
  resources :ships
  resources :resources
  resources :pilots
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/404" => "errors#not_found"
  get "/500" => "errors#exception"
  # Defines the root path route ("/")
  # root "articles#index"
end
