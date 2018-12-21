require 'fcm'
#
class FcmLib
  def self.send(tokens, content, badge)
    if @fcm.nil?
      @fcm = FCM.new(Rails.application.credentials.dig(:firebase, :server_key))
    end

    options = {
      notification: {
        text: content,
        badge: badge
      }
    }
    @fcm.send(tokens, options)
  end

  def self.success?(tokens, content, badge = 0)
    JSON.parse(self.send(tokens, content, badge)[:body])['success'] == 1
  end
end
