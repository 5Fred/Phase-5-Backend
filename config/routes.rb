Rails.application.routes.draw do
  # News Articles routes
  resources :news_articles, only: [:index, :show]
  # Add other routes for create, update, and delete actions if needed

  # User Preferences routes
  resources :users, only: [:index,:show,:create] do
    resource :user_preferences, only: [:show, :create, :update]
    # Add other routes for delete action if needed
  end
end
