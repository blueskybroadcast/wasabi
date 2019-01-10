class SlackService
  attr_reader :token, :client

  def initialize(auth_token:)
    @token = auth_token
    @client = Slack::Web::Client.new(token: @token)
  end

  def user_profile
    client.users_profile_get['profile']
  end

  def refresh_custom_fields
    ids = []
    fields = client.team_profile_get['profile']['fields']
    fields.each do |field|
      custom_field = CustomField.find_or_create_by(CustomField.translated_data(field))
      ids << custom_field.field_id
    end
  end

  def refresh_all_users
    list = client.users_list
    list.each do |section|
      next unless section[0] == 'members'
      section[1].each do |u|
        next if u['deleted'] == false || u['deleted'] == 'false'
        next if u['name'] == 'slackbot'
        auth_hash = translate_to_auth_hash(u)
        user = User.find_or_create_by_oauth(auth_hash)
        puts "=== Updated #{user.first_name} #{user.last_name}"
        user.update_custom_fields
        puts "=== Updated #{user.first_name} #{user.last_name} custom fields"
      end
    end
  end

  private

  def translate_to_auth_hash(user_data)
    {
      'credentials' => {
        'token' => 'nan'
      },
      'extra' => {
        'user_info' => {
          'user' => {
            'profile' => {
              'display_name' => user_data['profile']['display_name'],
              'phone' => user_data['profile']['phone']
            }
          }
        }
      },
      'uid' => user_data['id'],
      'info' => {
        'email' => user_data['profile']['email'] || 'no-email@email-missing.com',
        'user' => user_data['name'],
        'time_zone' => user_data['tz'] || 'America/Los_Angeles',
        'image' => user_data['profile']['image_original'],
        'first_name' => user_data['profile']['first_name'],
        'last_name' => user_data['profile']['last_name'],
        'description' => user_data['profile']['title']
      }
    }
  end
end
