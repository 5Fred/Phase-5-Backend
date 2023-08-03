# app/controllers/bookmarks_controller.rb

class BookmarksController < ApplicationController
    skip_before_action :authenticate_user 
    before_action :set_bookmark, only: [:destroy]
  
    def index
      bookmarks = Bookmark.all
      render json: bookmarks
    end
  
    def create
      # Decode the JWT token to get the user ID
      token = request.headers['Authorization']&.split(' ')&.last
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      user_id = decoded_token.first['user_id']
  
      # Create the bookmark with the associated user_id
      bookmark = Bookmark.new(bookmark_params.merge(user_id: user_id))
  
      if bookmark.save
        render json: bookmark, status: :created
      else
        render json: { error: bookmark.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @bookmark.destroy
      head :no_content
    end
  
    private
  
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end
  
    def bookmark_params
      params.require(:bookmark).permit(:news_article_id)
    end
  end
  