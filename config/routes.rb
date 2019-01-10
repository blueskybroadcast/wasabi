Rails.application.routes.draw do
  root to: 'application#index'
  get '/auth/slack/callback', to: 'sessions#create'
  resources :users
end
