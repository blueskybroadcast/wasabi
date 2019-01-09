module UserHelper
  def custom_fields_and_labels(user)
    data = []
    user.custom_responses.each do |response|
      data << { label: response.custom_field.field_label, value: response.response}
    end
    data
  end
end
