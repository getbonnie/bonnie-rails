#
class Device < ApplicationRecord
  belongs_to :user

  validates :reference, :token, presence: true
end
