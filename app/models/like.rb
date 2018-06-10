#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true

  LIKABLE_TYPES = %w[
    Pew
    Comment
  ].freeze

  validates :likable_type, inclusion: { in: LIKABLE_TYPES }

  def self.likable_types
    LIKABLE_TYPES
  end
end
