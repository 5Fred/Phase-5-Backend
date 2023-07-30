class User < ApplicationRecord
    has_secure_password
      has_many :bookmarks
      has_many :user_preferences
    
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true
    validates :password, presence: true, length: { minimum: 6 }
  end
  