class OpenaiService
    require 'openai'
  
    def initialize
      # Replace 'YOUR_OPENAI_API_KEY' with your actual API key
      @client = Openai::Client.new(api_key: ENV['OPEN_AI_KEY'])
    end
  
    def analyze_sentiment(article_content)
      response = @client.analyze_sentiment(
        model: 'YOUR_MODEL_NAME', # Replace with the name of the sentiment analysis model you want to use
        text: article_content
      )
      # Assuming the API response contains sentiment information
      sentiment = response['sentiment']
      return sentiment
    rescue Openai::OpenaiError => e
      # Handle API call errors here
      Rails.logger.error "Error calling OpenAI API: #{e.message}"
      return nil
    end
  end
  