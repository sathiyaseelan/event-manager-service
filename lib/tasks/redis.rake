namespace :redis do

  desc "Populate emails for auto complete"
  task :load => :environment do
    SearchSuggestion.seed_emails_to_redis
  end

  desc "Clear existing emails"
  task :clear => :environment do
    SearchSuggestion.clear_emails
  end
end
