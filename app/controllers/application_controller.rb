class ApplicationController < ActionController::API
    before_action :authenticate_user, unless: :public_action? # Add the unless condition to skip authentication for public actions
  
    private
  
    def authenticate_user
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        decoded_token = JWT.decode(header, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
        @current_user = User.find(decoded_token.first['user_id'])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end

    def public_action?
        # Return true for any actions that should be accessible without authentication
        controller_name == 'news_articles' && action_name == 'index'
    end 
    
  end
  