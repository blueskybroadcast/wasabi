namespace :users do
  task refresh_all: :environment do
    SlackService.new.refresh_all_users
  end
end
