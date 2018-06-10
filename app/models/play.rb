#
class Play < ApplicationRecord
  belongs_to :user
  belongs_to :playable, polymorphic: true

  PLAYABLE_TYPES = %w[
    Pew
    Comment
  ].freeze

  validates :playable_type, inclusion: { in: PLAYABLE_TYPES }

  def self.playable_types
    PLAYABLE_TYPES
  end
end
