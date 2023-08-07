require 'net/http'
require 'json'

class SentimentAnalysisController < ApplicationController
  skip_before_action :authenticate_user

  def analyze
    url = params[:url]
    sentiment_analysis_result = perform_sentiment_analysis(url)

    puts sentiment_analysis_result
    render json: sentiment_analysis_result
  end

  def perform_sentiment_analysis(url)
    api_url = URI("https://news-sentiment2.p.rapidapi.com/")
    api_url.query = URI.encode_www_form({ url: url })
  
    http = Net::HTTP.new(api_url.host, api_url.port)
    http.use_ssl = true
  
    request = Net::HTTP::Get.new(api_url)
    request["X-RapidAPI-Key"] = "8d35c8f1a7mshb54a8aa5802f1ddp149814jsnbeb60a181547"
    request["X-RapidAPI-Host"] = 'news-sentiment2.p.rapidapi.com'
  
    puts "Sending request to API: #{request.inspect}"
    
    response = http.request(request)
  
    puts "Received response from API: #{response.inspect}"
  
    # Check for 204 No Content status
    if response.is_a?(Net::HTTPNoContent)
      return {
        sentiment: "Neutral",
        sentiment_score: "O",
        sentiment_probabilities: nil
      }
    end
  
    parsed_response = JSON.parse(response.read_body)
  
    sentiment = parsed_response['message']['sentimentprediction']
  
    if sentiment
      sentiment = sentiment.to_s
    else
      sentiment = 'Unknown'
    end
  
    sentiment_score = parsed_response['message']['sentimentscore'] || 'N/A'
  
    {
      sentiment: sentiment,
      sentiment_score: sentiment_score,
      sentiment_probabilities: parsed_response['message']['sentimentprobabilities']
    }
  end
  
  
  
end
