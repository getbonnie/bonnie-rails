#
class Play < ApplicationRecord
  belongs_to :user
  belongs_to :playable, polymorphic: true

  PLAYABLE_TYPES = %w[
    Reaction
    Comment
  ].freeze

  validates :playable_type, inclusion: { in: PLAYABLE_TYPES }
end
