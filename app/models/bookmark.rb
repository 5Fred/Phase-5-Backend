class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :news_article

  # Validation to ensure a user can bookmark an article only once
  validates :user_id, uniqueness: { scope: :news_article_id }
end
