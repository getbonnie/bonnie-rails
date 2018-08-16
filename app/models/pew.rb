#
class Pew < ApplicationRecord
  attr_accessor :sound_base64

  after_create :parse_sound
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

  def parse_sound
    return false if sound_base64.nil?

    base64 = %r{^data:audio\/aac;base64,(.+)$}.match(sound_base64)
    if base64.nil? || base64.length != 2
      errors.add(:base, 'Wrong base64 format')
    end

    if Base64.strict_decode64(base64[1]).nil?
      errors.add(:base, 'Decoding base64 failed.')
    end

    filename = "#{SecureRandom.uuid}.aac"
    filepath = Rails.root.join('tmp', filename)

    File.open(filepath, 'wb') do |f|
      f.write(Base64.strict_decode64(base64[1]))
    end

    sound.attach(
      io: File.open(filepath),
      filename: filename,
      content_type: 'audio/aac'
    )
    FileUtils.rm(filepath)
  end

  def default_values
    self.uuid ||= SecureRandom.uuid
    self.status ||= :pending
  end
end
