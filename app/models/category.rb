#
class Category < ApplicationRecord
  before_save :default_values

  has_many :questions, dependent: :destroy

  enum status: {
    active: 1,
    deleted: -1
  }

  validates :name, :color, presence: true
  validates :status, allow_nil: true, inclusion: { in: statuses }

  def default_values
    self.status ||= :active
  end

  def questions_count
    Question.active.where(category_id: id).count
  end
end
