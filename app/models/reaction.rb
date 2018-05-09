#
class Reaction < ApplicationRecord
  before_save :default_values

  belongs_to :question
  belongs_to :user
  belongs_to :emotion
  has_many :comments, dependent: :destroy
  has_one_attached :sound

  STATES = %i[
    pending
    active
    deleted
  ].freeze

  validates :state, allow_nil: true, inclusion: { in: STATES.map(&:to_s) }

  scope :active, -> { where(state: :active) }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.state ||= 'pending'
  end

  def self.states
    STATES
  end
end
