class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  before_action :find_user, only: [:show, :update, :destroy]
  
  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    render json: @user, status: 200
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 201
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  def destroy
    @user.destroy
  end

  def show_preferences
    user_preference = UserPreference.find_by(user_id: @current_user.id)
    render json: user_preference
  end

  def update_preferences
    user_preference = UserPreference.find_or_create_by(user_id: @current_user.id)
    if user_preference.update(user_preference_params)
     render json: user_preference
    else  
     render json: {errors: user_preference.errors.full_messages} , status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:username, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
  def user_preference_params
    params.require(:user).permit(:hide_negative_sentiment, :hide_positive_sentiment, :hide_neutral_sentiment)
  end
end
