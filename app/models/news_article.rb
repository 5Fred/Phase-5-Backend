class NewsArticle < ApplicationRecord
  has_many :bookmarks
  has_many :users, through: :bookmarks
  has_many :user_preferences, through: :users
  validates :headline, :summary, :content, :publication_date, presence: true
  
    
  end
  