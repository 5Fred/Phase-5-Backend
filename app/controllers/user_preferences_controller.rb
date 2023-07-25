
class UserPreferencesController < ApplicationController
    # Show action to fetch user-specific sentiment analysis preferences
    def show
      user = User.find(params[:user_id])
      user_preferences = user.user_preferences
      render json: user_preferences, status: :ok
    end
  
    # Create action to handle user-specific sentiment analysis preferences
    def create
      user = User.find(params[:user_id])
      user_preferences = user.build_user_preferences(user_preferences_params)
      if user_preferences.save
        render json: user_preferences, status: :created
      else
        render json: { errors: user_preferences.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # Update action to update user-specific sentiment analysis preferences
    def update
      user_preferences = UserPreferences.find(params[:id])
      if user_preferences.update(user_preferences_params)
        render json: user_preferences, status: :ok
      else
        render json: { errors: user_preferences.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # Other actions for Delete operations
  end
  