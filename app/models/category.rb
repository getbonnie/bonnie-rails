#
class Category < ApplicationRecord
  before_save :default_values
  after_commit :upload_cache

  has_many :topics, dependent: :destroy

  enum status: {
    active: 1,
    deleted: -1
  }

  validates :name, :color, presence: true
  validates :status, allow_nil: true, inclusion: { in: statuses }

  def default_values
    self.status ||= :active
  end

  def topics_count
    Topic.active.where(category_id: id).count
  end
end
