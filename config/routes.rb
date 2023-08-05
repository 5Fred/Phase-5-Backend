Rails.application.routes.draw do
  # News Articles routes
  resources :news_articles, only: [:index, :show ,:create, :update, :destroy]
  # Add other routes for create, update, and delete actions if needed

  # User Preferences routes
  get '/users/preferences', to: 'users#show_preferences'
  patch '/users/preferences', to: 'users#update_preferences'
  
  resources :users, only: [:index, :show, :create, :update, :destroy] do
    resource :user_preferences, only: [:show, :update]
  end
  # Users route for create, read, update, and delete actions
  resources :users

  # Authentication route
  post '/auth/login', to: 'authentication#login'
  resources :bookmarks, only: [:index, :create, :destroy]
  post 'sentiment_analysis', to: 'sentiment_analysis#analyze'

  # Handle OPTIONS request for /users endpoint
  match '/users', to: 'application#handle_options_request', via: :options

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
