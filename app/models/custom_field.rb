class CustomField < ApplicationRecord
  has_many :custom_responses, dependent: :destroy
  has_many :users, through: :custom_responses

  validates :field_id, presence: true
  validates :field_label, presence: true
  validates :field_type, presence: true

  def self.translated_data(field)
    {
      field_id: field['id'],
      field_label: field['label'],
      field_type: field['type'],
    }
  end

end
