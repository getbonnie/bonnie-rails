#
class Device < ApplicationRecord
  belongs_to :user

  validates :reference, presence: true
end
