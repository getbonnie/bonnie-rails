#
class Follower < ApplicationRecord
  belongs_to :user
  belongs_to :followed, class_name: 'User', foreign_key: :followed_id, inverse_of: :followed_by
end
