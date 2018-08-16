#
class Like < ApplicationRecord
  after_commit :recount

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

  def recount
    # Update count
    likable.update(
      likes_count: Like.where(likable: likable).count
    )
  end
end
