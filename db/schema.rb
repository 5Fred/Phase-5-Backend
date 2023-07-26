# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.


ActiveRecord::Schema.define(version: 2023_07_25_103519) do

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "news_article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["news_article_id"], name: "index_bookmarks_on_news_article_id"
    t.index ["user_id", "news_article_id"], name: "index_bookmarks_on_user_id_and_news_article_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "news_articles", force: :cascade do |t|
    t.string "headline", null: false
    t.text "summary", null: false
    t.text "content", null: false
    t.datetime "publication_date", null: false
    t.string "sentiment", default: "neutral", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_preferences", force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "hide_negative_sentiment", default: false
    t.boolean "hide_positive_sentiment", default: false
    t.boolean "hide_neutral_sentiment", default: false
    t.boolean "prioritize_positive_news", default: false
    t.boolean "prioritize_negative_news", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_preferences_on_user_id"
  end

  add_foreign_key "bookmarks", "news_articles"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "user_preferences", "users"
ActiveRecord::Schema.define(version: 2023_07_26_045358) do

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
