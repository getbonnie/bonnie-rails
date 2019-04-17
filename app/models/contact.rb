# !
class Contact < ApplicationRecord
  before_save :default_values

  belongs_to :user

  validates :phone_number, phone: true

  def default_values
    self.uuid ||= SecureRandom.uuid
  end
end
