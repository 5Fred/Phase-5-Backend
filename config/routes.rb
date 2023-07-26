Rails.application.routes.draw do
  # News Articles routes
  resources :news_articles, only: [:index, :show]
  # Add other routes for create, update, and delete actions if needed

  # User Preferences routes
  resources :users, only: [] do
    resource :user_preferences, only: [:show, :create, :update]
    # Add other routes for delete action if needed
  end

  # Users route for create, read, update, and delete actions
  resources :users

  # Authentication route
  post '/auth/login', to: 'authentication#login'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
