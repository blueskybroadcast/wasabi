class SlackService
  IGNORE_USERNAMES = [
    'confluence',
    'github',
    'asana',
    'trello',
    'prodpad',
    'surveymonkey',
    'leo_officevibe_bot',
    'slackbot',
    'sentry',
    'googledrive',
    'jirabot',
    'spacetime',
    'github_mention'
  ]
  attr_reader :token, :client

  def initialize(auth_token: nil)
    @token = auth_token || get_a_token
    @client = Slack::Web::Client.new(token: @token)
  end

  def user_profile(user_id: nil)
    if user_id.nil?
      client.users_profile_get['profile']
    else
      client.users_profile_get(user: user_id)['profile']
    end
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
    list = client.users_list(limit: 150)
    list.each do |k, val|
      next unless k == 'members'
      val.each do |u|
        next if u['deleted'] == true || u['deleted'] == 'true'
        next if IGNORE_USERNAMES.include?(u['name'])
        next if u['profile']['first_name'].blank? && u['profile']['last_name'].blank?
        auth_hash = translate_to_auth_hash(u)
        user = User.find_or_create_by_oauth(auth_hash)
        puts "=== Added/Updated #{user.auth_username} (#{user.first_name} #{user.last_name})"
      end
    end
  end

  private

  def get_a_token
    user = User.where("auth_token != 'nan'").first
    if user.nil?
      ENV['SLACK_USER_TOKEN']
    else
      user.auth_token
    end
  end

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
