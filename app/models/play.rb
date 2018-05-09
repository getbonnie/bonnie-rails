#
class Play < ApplicationRecord
  belongs_to :user
  belongs_to :playable, polymorphic: true

  PLAYABLE_TYPES = %i[
    Reaction
    Comment
  ].freeze

  validates :playable_type, inclusion: { in: PLAYABLE_TYPES.map(&:to_s) }

  def self.playable_types
    PLAYABLE_TYPES
  end
end
