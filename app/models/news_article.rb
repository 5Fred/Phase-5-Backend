class NewsArticle < ApplicationRecord
    validates :headline, :summary, :content, :publication_date, presence: true
  
    # Add the image_url and author_name fields to the list of permitted attributes
    # to prevent mass assignment vulnerabilities.
    # For Rails versions < 4.1, use attr_accessible instead.
    # For Rails versions >= 4.1 and <= 6.0, use the `attributes` method instead of `require`.
    # For Rails versions >= 6.1, the `attributes` method is deprecated, and mass assignment is allowed by default.
    # You can remove the `attributes` method completely in Rails 6.1+.
    def self.create_from_api_response(article)
      permitted_attributes = article.slice(:headline, :summary, :content, :publication_date, :image_url, :author_name)
      create!(permitted_attributes)
    end
  end
  