#
class Question < ApplicationRecord
  before_save :default_values

  belongs_to :topic
  belongs_to :category, optional: true
  has_many :reactions, dependent: :destroy

  STATES = %i[
    pending
    active
    deleted
  ].freeze

  validates :short, presence: true
  validates :state, allow_nil: true, inclusion: { in: STATES.map(&:to_s) }

  scope :active, -> { where(state: :active) }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.state ||= 'pending'
  end

  def self.states
    STATES
  end

  def reactions_count
    Reaction.active.where(question_id: id).count
  end
end
