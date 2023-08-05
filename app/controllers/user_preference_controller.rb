class UserPreferenceController < ApplicationController
  before_action :authenticate_user

  def show
    user_preference = @current_user.user_preference
    render json: user_preference
  end

  def update
    user_preference = @current_user.user_preference || @current_user.build_user_preference

    if user_preferences.update(user_preference_params)
      render json: user_preference
    else
      render json: { error: user_preference.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def user_preference_params
    params.require(:user_preference).permit(
      :hide_negative_sentiment,
      :hide_positive_sentiment,
      :hide_neutral_sentiment,
      :prioritize_positive_news,
      :prioritize_negative_news
    )
  end
end
