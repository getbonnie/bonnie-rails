#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true

  LIKABLE_TYPES = %w[
    Reaction
    Comment
  ].freeze

  validates :likable_type, inclusion: { in: LIKABLE_TYPES }
end
