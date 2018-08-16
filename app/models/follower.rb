#
class Follower < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: :user_id, inverse_of: :following
  belongs_to :following, class_name: 'User', foreign_key: :followed_id, inverse_of: :followed_by
end
