#
class Emotion < ApplicationRecord
  before_save :default_values

  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy

  STATES = %i[
    pending
    active
    deleted
  ].freeze

  validates :name, presence: true
  validates :state, allow_nil: true, inclusion: { in: STATES.map(&:to_s) }

  def default_values
    self.state ||= 'pending'
  end

  def self.states
    STATES
  end
end
