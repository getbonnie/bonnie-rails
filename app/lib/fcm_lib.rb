require 'fcm'
#
class FcmLib
  def self.send(tokens, content)
    if @fcm.nil?
      @fcm = FCM.new(Rails.application.credentials.dig(:firebase, :server_key))
    end

    options = {
      notification: {
        text: content
      }
    }
    @fcm.send(tokens, options)
  end

  def self.success?(tokens, content)
    JSON.parse(self.send(tokens, content)[:body])['success'] == 1
  end
end
