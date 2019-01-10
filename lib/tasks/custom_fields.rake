namespace :custom_fields do
  task refresh: :environment do
    SlackService.new.refresh_custom_fields
    puts "=== Done refreshing custom fields."
  end
end
