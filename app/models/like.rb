#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true

  LIKABLE_TYPES = %i[
    Reaction
    Comment
  ].freeze

  validates :likable_type, inclusion: { in: LIKABLE_TYPES.map(&:to_s) }

  def self.likable_types
    LIKABLE_TYPES
  end
end
