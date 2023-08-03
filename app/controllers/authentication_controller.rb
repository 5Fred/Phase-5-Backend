class AuthenticationController < ApplicationController
    skip_before_action :authenticate_user

    def login
      @user = User.find_by_email(params[:email])
      if @user&.authenticate(params[:password])
        token = JwtToken.jwt_encode({ user_id: @user.id }, exp: 24.hours.from_now)
        render json: { token: token, username: @user.username }, status: :ok
      else
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    end

end
  