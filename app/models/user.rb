class User < ApplicationRecord
  has_secure_password
  has_many :bookmarks

  has_many :news_articles, through: :bookmarks 

  has_many :news_articles, through: :bookmarks

  has_one :user_preference, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  validate :password_confirmation_matches_password

  def password_confirmation_matches_password
    if password_confirmation != password
      errors.add(:password_confirmation, "doesn't match Password")
    end
  end
end
