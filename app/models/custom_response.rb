class CustomResponse < ApplicationRecord
  belongs_to :user
  belongs_to :custom_field
end
