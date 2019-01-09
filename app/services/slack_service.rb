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
end
