class NewsArticle < ApplicationRecord
  belongs_to :user_preference 
  has_many :bookmarks
  has_many :users, through: :bookmarks
  validates :headline, :summary, :content, :publication_date, presence: true
  
  
  scope :filtered_by_user_preference, ->(user_preference) {
    allowed_sentiments = user_preference.allowed_sentiments
    where(sentiment: allowed_sentiments)
  }  
  end
  