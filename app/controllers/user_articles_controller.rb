class UserArticlesController < ApplicationController
    before_action :authenticate_user

  def index
    user_articles = @current_user.news_articles
    render json: user_articles
  end
end
