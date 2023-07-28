# lib/tasks/unseed.rake
namespace :db do
    desc 'Unseed the database'
    task unseed: :environment do
      NewsArticle.destroy_all # Replace NewsArticle with your model name
      puts 'Database unseeded.'
    end
  end