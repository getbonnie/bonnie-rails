#
class Pew < ApplicationRecord
  attr_accessor :sound_base64

  after_create :set_attachment
  before_save :default_values

  belongs_to :user
  belongs_to :emotion
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy, inverse_of: :likable
  has_many :plays, as: :playable, dependent: :destroy, inverse_of: :playable
  has_one_attached :sound

  enum status: {
    pending: 0,
    active: 1,
    deleted: -1
  }.freeze

  validates :status, allow_nil: true, inclusion: { in: statuses }

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

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :active
  end
end
