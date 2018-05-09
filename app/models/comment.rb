#
class Comment < ApplicationRecord
  before_save :default_values

  belongs_to :user
  belongs_to :emotion
  belongs_to :reaction
  belongs_to :comment, optional: true
  has_many :comments, dependent: :destroy

  STATES = %i[
    pending
    active
    deleted
  ].freeze

  validates :state, allow_nil: true, inclusion: { in: STATES.map(&:to_s) }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.state ||= 'pending'
  end

  def self.states
    STATES
  end
end
