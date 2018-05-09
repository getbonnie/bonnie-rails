#
class Category < ApplicationRecord
  before_save :default_values

  has_many :questions, dependent: :destroy

  STATES = %i[
    active
    deleted
  ].freeze

  validates :name, :color, presence: true
  validates :state, allow_nil: true, inclusion: { in: STATES.map(&:to_s) }

  def default_values
    self.state ||= 'active'
  end

  def self.states
    STATES
  end

  def questions_count
    Question.active.where(category_id: id).count
  end
end
