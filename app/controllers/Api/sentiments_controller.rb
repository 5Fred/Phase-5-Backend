class Api::SentimentsController < ApplicationController
    skip_before_action :authenticate_user, only: :analyze_sentiment

    def analyze_sentiment
      encoded_params = URI.encode_www_form('text' => params[:text])
  
      response = RestClient.post(
        'https://text-sentiment.p.rapidapi.com/analyze',
        encoded_params,
        {
          'content-type' => 'application/x-www-form-urlencoded',
          'X-RapidAPI-Key' => '4990ecd6bbmsh93f9758a2e3467ap104e5cjsn1ac3e5b48e93',
          'X-RapidAPI-Host' => 'text-sentiment.p.rapidapi.com'
        }
      )
  
      render json: response.body
    rescue RestClient::ExceptionWithResponse => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
  