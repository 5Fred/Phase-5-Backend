class UserPreference < ApplicationRecord
    has_many :news_articles
    belongs_to :user
    def allowed_sentiments
        sentiments = []
        sentiments += ['positive', 'neutral'] unless hide_negative_sentiment
        sentiments += ['negative', 'neutral'] unless hide_positive_sentiment
        sentiments += ['positive', 'negative'] unless hide_neutral_sentiment
        sentiments.uniq
    end
end

