# !
class NotificationSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :pew
end
