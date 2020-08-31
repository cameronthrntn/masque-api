Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :topics
  get '/topics/:id/comments', to: 'comments#show'
  get '/api', to: 'api#index'
end
