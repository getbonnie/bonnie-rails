# !
class Contact < ApplicationRecord
  before_save :default_values

  belongs_to :user
  belongs_to :synced_user, class_name: 'User', primary_key: :phone_number, foreign_key: :phone, inverse_of: :synced_contacts, optional: true

  validates :phone_number, phone: true

  def default_values
    self.uuid ||= SecureRandom.uuid
  end
end
