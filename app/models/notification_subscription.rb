# !
class NotificationSubscription < ApplicationRecord
  before_save :default_values

  belongs_to :user
  belongs_to :pew

  def default_values
    self.uuid ||= SecureRandom.uuid
  end
end
