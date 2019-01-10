class User < ApplicationRecord
  has_many :custom_responses, dependent: :destroy
  has_many :custom_fields, through: :custom_responses

  def self.find_or_create_by_oauth(auth_hash)
    translated_data = User.translated_auth_data(auth_hash)
    user = User.where('LOWER(auth_user_id) = ?', translated_data[:auth_user_id].downcase).first
    if user.nil?
      user = User.create!(translated_data) unless user.present?
    else
      user.update!(translated_data)
    end
    user.update_custom_fields
    user
  end

  def update_custom_fields
    SlackService.new.user_profile['fields'].each do |field|
      custom_field = CustomField.where(field_id: field[0]).first
      if custom_field.present?
        response = CustomResponse.where(custom_field: custom_field, user: self).first
        if response.present?
          response.update!(response: field[1]['value'])
        else
          CustomResponse.create!(custom_field: custom_field, user: self, response: field[1]['value'])
        end
      end
    end
    true
  end

  def self.translated_auth_data(auth_hash)
    {
      email: auth_hash['info']['email'],
      auth_token: auth_hash['credentials']['token'],
      auth_username: auth_hash['info']['user'],
      auth_user_id: auth_hash['uid'],
      time_zone: auth_hash['info']['time_zone'],
      avatar: auth_hash['info']['image'],
      display_name: auth_hash['extra']['user_info']['user']['profile']['display_name'],
      first_name: auth_hash['info']['first_name'],
      last_name: auth_hash['info']['last_name'],
      phone_office: auth_hash['extra']['user_info']['user']['profile']['phone'],
      what_i_do: auth_hash['info']['description'],
    }
  end
end
