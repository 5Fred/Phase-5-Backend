class CreateNewsArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :news_articles do |t|
      t.string :headline, null: false
      t.text :summary, null: false
      t.text :content, null: false
      t.datetime :publication_date, null: false
      t.string :sentiment, default: 'neutral', null: false
      t.timestamps
    end
  end
end
