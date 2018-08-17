#
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  attr_accessor :filename
  attr_accessor :filepath

  def upload_cache
    GoogleCloud.instance.upload_cache
  end

  def decode_file(raw_base64, mime)
    return false if raw_base64.nil?

    extension = mime.split('/')[1]
    base64 = /^data:#{mime};base64,(.+)$/.match(raw_base64)
    if base64.nil? || base64.length != 2
      errors.add(:base, 'Wrong base64 format')
    end

    if Base64.strict_decode64(base64[1]).nil?
      errors.add(:base, 'Decoding base64 failed.')
    end

    self.filename = "#{SecureRandom.uuid}.#{extension}"
    self.filepath = Rails.root.join('tmp', filename)

    File.open(filepath, 'wb') do |f|
      f.write(Base64.strict_decode64(base64[1]))
    end

    true
  end
end
