class ApplicationController < ActionController::API
    include ActionController::Cookies
    include JwtToken
    before_action :authenticate_user

    private
    def authenticate_user
        header = request.headers ['Authorization']
        header = header.split(" ").last if header
        begin
            @decoded = JwtToken.decode(header)
            @current_user = User.find(@decode[:user_id])
        rescue ActiveRecord::RecordNotFound => e
            render json: {errors: e.message}, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: {errors: e.message}, status: :unauthorized
        end
    end
    
    def handle_options_request
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'X-Requested-With, Content-Type, Authorization'
        head :ok
      end
end
