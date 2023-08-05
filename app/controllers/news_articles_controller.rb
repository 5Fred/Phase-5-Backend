class NewsArticlesController < ApplicationController
  skip_before_action :authenticate_user, only: [:index , :show]

  def index
    user_preference = current_user&.user_preference

    if user_preference.present?
      if user_preference.hide_negative_sentiment
        @news_articles = NewsArticle.where.not(sentiment: 'negative')
      elsif user_preference.hide_positive_sentiment
        @news_articles = NewsArticle.where.not(sentiment: 'positive')
      elsif user_preference.hide_neutral_sentiment
        @news_articles = NewsArticle.where.not(sentiment: 'neutral')
      else
        @news_articles = NewsArticle.all
      end
    else
      @news_articles = NewsArticle.all
    end

    render json: @news_articles
  end

  def show
    @news_article = NewsArticle.find(params[:id])
    render json: @news_article
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: 'News article not found' }, status: :not_found
  end
  private

  def current_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      decoded_token = JWT.decode(header, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      @current_user = User.find(decoded_token.first['user_id'])
    rescue ActiveRecord::RecordNotFound => e
      nil
    rescue JWT::DecodeError => e
      nil
    end
  end
end
