# !
class Pew < ApplicationRecord
  attr_accessor :sound_base64

  after_create :set_attachment
  after_create_commit :send_push
  after_save :insert_hashtags,  if: :saved_change_to_inline_hashtags?
  before_save :default_values
  before_destroy :clean_fast

  belongs_to :user
  belongs_to :emotion
  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy, inverse_of: :likable
  has_many :plays, as: :playable, dependent: :destroy, inverse_of: :playable
  has_many :notifications, as: :notificationable, dependent: :destroy, inverse_of: :notificationable
  has_many :notification_subscriptions, dependent: :destroy
  has_one_attached :sound

  enum status: {
    pending: 0,
    active: 1,
    deleted: -1
  }.freeze

  validates :status, allow_nil: true, inclusion: { in: statuses }
  validates :inline_hashtags, presence: true

  def hashtag
    return if inline_hashtags.empty?

    (inline_hashtags.split)[0]
  end

  private

  def set_attachment
    mime = 'audio/aac'

    return false unless decode_file(sound_base64, mime)

    sound.attach(
      io: File.open(filepath),
      filename: filename,
      content_type: mime
    )
    FileUtils.rm(filepath)
  end

  def insert_hashtags
    array_hashtags = inline_hashtags.split

    Hashtag.where(pew: self).delete_all

    array_hashtags.each do |hashtag|
      Hashtag.create(pew: self, tag: hashtag)
    end
  end

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :active
    self.inline_hashtags = Pew.sanitize_hashtags(inline_hashtags)
  end

  def clean_fast
    notifications.delete_all
    notification_subscriptions.delete_all
    hashtags.delete_all
    plays.delete_all
    likes.delete_all
    comments.each do |comment|
      comment.plays.delete_all
      comment.likes.delete_all
    end
  end

  def send_push
    serializer = ActiveModelSerializers::SerializableResource.new(
      self,
      serializer: Api::V1::Pews::PewSerializer
    )

    FcmLib.send_to_topic('pews', serializer.as_json, :pews)
  end

  def self.sanitize_hashtags(hashtags)
    return nil unless hashtags

    hashtags.gsub!(/[^A-Za-z0-9\-\.\_ ]/, '')
    hashtags = hashtags.split
    hashtags.join(' ')
  end
end
