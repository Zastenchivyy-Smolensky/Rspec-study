Rails.application.routes.draw do
  get '/index', to:"posts#index"
  get '/show', to: "posts#show"
  get '/new', to: "posts#new"
  get '/edit', to: "posts#edit"
  resources :posts

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
