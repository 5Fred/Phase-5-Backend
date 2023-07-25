class NewsArticle < ApplicationRecord
    has_many :bookmarks, dependent: :destroy

end
