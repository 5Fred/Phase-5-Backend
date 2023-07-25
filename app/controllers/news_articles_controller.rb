class NewsArticlesController < ApplicationController
    # Index action to fetch all news articles
    def index
      news_articles = NewsArticle.all
      render json: news_articles, status: :ok
    end
  
    # Show action to fetch a specific news article by ID
    def show
      news_article = NewsArticle.find(params[:id])
      render json: news_article, status: :ok
    end
  
    # Other actions for Create, Update, and Delete operations
  end
  

