# seeds.rb
puts "Started seeding"
require 'dotenv/load'
require 'news-api'

api_key = ENV['API_KEY']
newsapi = News.new(api_key)

# Get top headlines from the News API
response = newsapi.get_top_headlines(sources: 'bbc-news', language: 'en', pageSize: 20)
articles = response # The articles are stored in the 'articles' field

# Seed news articles
articles.each do |article|
  NewsArticle.create!(
    headline: article.title,
    summary: article.description,
    content: article.content,
    publication_date: article.publishedAt,
    sentiment: 'neutral', # Assuming 'neutral' sentiment for now
    image_url: article.urlToImage, # Add the image_url field from the 'urlToImage' field in the API response
    author_name: article.author, # Add the author_name field from the 'author' field in the API response
    url: article.url # Add the URL of the article
  )
end

puts "Done seeding"


