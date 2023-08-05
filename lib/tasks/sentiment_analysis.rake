# lib/tasks/sentiment_analysis.rake

namespace :sentiment_analysis do
  require 'net/http'
  require 'json'
  require 'dotenv/load'

  desc "Perform sentiment analysis on all NewsArticles"
  task analyze: :environment do
    NewsArticle.find_each do |news_article|
      sentiment_analysis_result = perform_sentiment_analysis(news_article.url)

      # Update the sentiment analysis results for the current news_article
      news_article.update(
        sentiment: sentiment_analysis_result[:sentiment],
        sentiment_score: sentiment_analysis_result[:sentiment_score]
      )

      puts "Sentiment analysis completed for NewsArticle ID: #{news_article.id}"
    end
  end

  private

  def perform_sentiment_analysis(url)
    api_url = URI("https://news-sentiment2.p.rapidapi.com/")
    api_url.query = URI.encode_www_form({ url: url })

    http = Net::HTTP.new(api_url.host, api_url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(api_url)
    request["X-RapidAPI-Key"] = "8d35c8f1a7mshb54a8aa5802f1ddp149814jsnbeb60a181547"
    request["X-RapidAPI-Host"] = 'news-sentiment2.p.rapidapi.com'

    response = http.request(request)
    parsed_response = JSON.parse(response.read_body)

    # Get sentiment and sentiment_score from the parsed_response
    message = parsed_response['message']
    if message.is_a?(Hash) && message.key?('sentimentprediction') && message.key?('sentimentscore')
      sentiment = message['sentimentprediction']
      sentiment_score = message['sentimentscore']
    else
      # Set default values if sentiment or sentiment_score is not available in the response
      sentiment = 'neutral'
      sentiment_score = { 'Neutral' => 1 } # Assuming a neutral sentiment with score 1
    end

    { sentiment: sentiment, sentiment_score: sentiment_score }
  end
end
