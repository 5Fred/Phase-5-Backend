# lib/tasks/sentiment_analysis.rake

namespace :sentiment_analysis do
  desc "Perform sentiment analysis on all NewsArticles"
  task analyze: :environment do
    require 'net/http'
    require 'json'

    NewsArticle.find_each do |news_article|
      sentiment_analysis_result = perform_sentiment_analysis(news_article.url)

      # Update the sentiment analysis results for the current news_article
      news_article.update(sentiment: sentiment_analysis_result[:sentiment],
                          sentiment_score: sentiment_analysis_result[:sentiment_score])

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
    request["X-RapidAPI-Key"] = ENV['X-RapidAPI-Key']
    request["X-RapidAPI-Host"] = 'news-sentiment2.p.rapidapi.com'

    response = http.request(request)
    parsed_response = JSON.parse(response.read_body)

    sentiment = parsed_response['message']['sentimentprediction']
    sentiment_score = parsed_response['message']['sentimentscore']

    { sentiment: sentiment, sentiment_score: sentiment_score }  end
end