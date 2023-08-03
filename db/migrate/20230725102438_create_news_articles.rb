class CreateNewsArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :news_articles do |t|
      t.string :headline, null: false
      t.text :summary, null: false
      t.text :content, null: false
      t.datetime :publication_date, null: false
      t.string :sentiment, default: 'neutral', null: false
      t.json :sentiment_score , null: false, default: {}
      t.string :image_url # Add a new column for image_url
      t.string :author_name # Add a new column for author_name
      t.string :url, null: false # Add a new column for the article URL

      t.timestamps
    end
  end
end
