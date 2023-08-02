namespace :sentiment_analysis do
    desc "Analyze the sentiment of all news articles"
    task analyze_all_articles: :environment do
      openai_service = OpenaiService.new
  
      NewsArticle.find_each do |news_article|
        sentiment = openai_service.analyze_sentiment(news_article.content)
        news_article.update(sentiment: sentiment) if sentiment.present?
      end
    end
  end