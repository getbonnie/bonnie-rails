#
class Flag < ApplicationRecord
  before_save :default_values

  belongs_to :user
  belongs_to :flagable, polymorphic: true

  TYPES = %i[
    behavior
    spam
  ].freeze

  STATES = %i[
    pending
    moderated
  ].freeze

  FLAGABLE_TYPES = %i[
    Reaction
    Comment
  ].freeze

  validates :flagable_type, inclusion: { in: FLAGABLE_TYPES.map(&:to_s) }
  validates :state, allow_nil: true, inclusion: { in: STATES.map(&:to_s) }
  validates :type_of, allow_nil: true, inclusion: { in: TYPES.map(&:to_s) }

  def default_values
    self.state ||= 'pending'
  end

  def self.types
    TYPES
  end

  def self.states
    STATES
  end

  def self.flagable_types
    FLAGABLE_TYPES
  end
end
