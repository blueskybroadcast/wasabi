namespace :custom_fields do
  task refresh: :environment do
    SlackService.new(auth_token: User.first.auth_token).refresh_custom_fields
    puts "=== Done refreshing custom fields."
  end
end
