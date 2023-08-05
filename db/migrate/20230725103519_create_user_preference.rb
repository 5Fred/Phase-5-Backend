class CreateUserPreference < ActiveRecord::Migration[6.0]
  def change
    create_table :user_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :hide_negative_sentiment, default: false
      t.boolean :hide_positive_sentiment, default: false
      t.boolean :hide_neutral_sentiment, default: false
    
      t.timestamps
    end
  end
end
