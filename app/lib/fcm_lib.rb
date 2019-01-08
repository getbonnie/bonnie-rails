require 'fcm'
#
class FcmLib
  def self.send_notification(tokens, content, badge)
    options = {
      notification: {
        text: content,
        badge: badge
      }
    }
    self.fcm.send(tokens, options)
  end

  def self.send_notification_success?(tokens, content, badge = 0)
    JSON.parse(self.send_notification(tokens, content, badge)[:body])['success'] == 1
  end

  def self.send_to_topic(topic, data, collapse_key = nil)
    payload = { data: data }
    payload.merge!(collapse_key: collapse_key) if collapse_key

    self.fcm.send_to_topic(topic, payload)
  end

  private

  def self.fcm
    if @fcm.nil?
      @fcm = FCM.new(Rails.application.credentials.dig(:firebase, :server_key))
    end

    @fcm
  end
end
