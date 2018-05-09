#
class Topic < ApplicationRecord
  before_save :default_values

  has_many :questions, dependent: :destroy
  has_one_attached :sticker

  STATES = %i[
    pending
    active
    suspended
    deleted
  ].freeze

  validates :name, presence: true
  validates :state, allow_nil: true, inclusion: { in: STATES.map(&:to_s) }

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.state ||= 'pending'
  end

  def self.states
    STATES
  end

  def questions_count
    Question.active.where(topic_id: id).count
  end
end
