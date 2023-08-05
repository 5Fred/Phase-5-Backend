class CreateNewsArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :news_articles do |t|
      t.string :headline, null: false
      t.text :summary, null: false
      t.text :content, null: false
      t.date :publication_date, null: false
      t.string :sentiment, default: 'neutral', null: false
      t.json :sentiment_score, null: false, default: {}
      t.string :image_url
      t.string :author_name
      t.string :url, null: false
     
      t.references :user_preference, foreign_key: true, default: nil

      t.timestamps
    end
  end
end
