# seeds.rb
puts "Started seeding"
require 'dotenv/load'
require 'news-api'
require 'httparty'
require 'nokogiri'

api_key = ENV['API_KEY']
newsapi = News.new(api_key)

# Get top headlines from the News API
response = newsapi.get_top_headlines(sources: 'bbc-news', language: 'en', pageSize: 20)
articles = response# Extract the 'articles' field from the API response

# Seed news articles
articles.each do |article_data|
  begin
    # Fetch the full article details using the article's URL
    article_response = HTTParty.get(article_data.url)
    article_html = article_response.body.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')

    # Parse the HTML and extract the main content using Nokogiri
    doc = Nokogiri::HTML(article_html)
    main_content = doc.css('article').text # You may need to adjust the selector based on the structure of the article page.

    NewsArticle.create!(
      headline: article_data.title,
      summary: article_data.description,
      content: main_content,
      publication_date: article_data.publishedAt,
      sentiment: 'neutral', # Assuming 'neutral' sentiment for now
      image_url: article_data.urlToImage, # Add the image_url field from the 'urlToImage' field in the API response
      author_name: article_data.author, # Add the author_name field from the 'author' field in the API response
      url: article_data.url # Add the URL of the article
    )
  rescue StandardError => e
    puts "Error occurred while fetching article content for: #{article_data.title}. Error: #{e.message}"
  end
end

puts "Done seeding"
