# !
class User < ApplicationRecord
  attr_accessor :avatar_base64

  after_save :set_attachment
  before_save :default_values

  has_many :comments, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :pews, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :notification_from, class_name: 'Notification', foreign_key: :from_id, inverse_of: :from, dependent: :destroy
  has_many :notification_subscriptions, dependent: :destroy
  has_many :following, class_name: 'Follower', foreign_key: :user_id, inverse_of: :follower, dependent: :destroy
  has_many :followed_by, class_name: 'Follower', foreign_key: :followed_id, inverse_of: :following, dependent: :destroy
  has_many :synced_contacts, class_name: 'Contact', primary_key: :phone, foreign_key: :phone_number, inverse_of: :synced_user, dependent: :destroy
  has_one_attached :avatar

  enum status: {
    pending: 0,
    active: 1,
    suspended: -1,
    deleted: -2
  }.freeze

  validates :status, allow_nil: true, inclusion: { in: statuses }

  def set_attachment
    mime = 'image/jpeg'

    return false unless decode_file(avatar_base64, mime)

    avatar.attach(
      io: File.open(filepath),
      filename: filename,
      content_type: mime
    )
    FileUtils.rm(filepath)
  end

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :pending
  end

  def age
    ((Time.zone.today - birthdate) / 365).floor if birthdate
  end

  def pews_count
    Pew.active.where(user_id: id).count
  end

  def comments_count
    Comment.active.where(user_id: id).count
  end

  def following_count
    Follower.where(user_id: id).count
  end

  def followed_count
    Follower.where(followed_id: id).count
  end

  def activate
    errors = []
    errors.push('Username') if similar_name?(name)
    errors.push('Age') if birthdate.blank? || age < 13
    errors.push('Name') if name.blank?
    errors.push('Picture') unless avatar.attachment

    return errors if errors.length.positive?

    update(status: :active)
    true
  end

  def similar_name?(new_name)
    User.where.not(id: id).where('lower(name) = ?', new_name.downcase).present?
  end
end
