require 'net/http'
require 'json'

class SentimentAnalysisController < ApplicationController
  def analyze
    news_article = NewsArticle.find(params[:id])
    sentiment_analysis_result = perform_sentiment_analysis(news_article.url)

    # Save the sentiment analysis results to the database
    news_article.update(sentiment: sentiment_analysis_result[:sentiment],
                        sentiment_score: sentiment_analysis_result[:sentiment_score])

    render json: { message: 'Sentiment analysis completed and results stored.' }
  end

  private

  def perform_sentiment_analysis(url)
    api_url = URI("https://news-sentiment2.p.rapidapi.com/")
    api_url.query = URI.encode_www_form({ url: url })

    http = Net::HTTP.new(api_url.host, api_url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(api_url)
    request["X-RapidAPI-Key"] = '8d35c8f1a7mshb54a8aa5802f1ddp149814jsnbeb60a181547'
    request["X-RapidAPI-Host"] = 'news-sentiment2.p.rapidapi.com'

    response = http.request(request)
    parsed_response = JSON.parse(response.read_body)

    sentiment = parsed_response['message']['sentimentprediction']
    sentiment_score = parsed_response['message']['sentimentscore']

    { sentiment: sentiment, sentiment_score: sentiment_score }
  end
end
