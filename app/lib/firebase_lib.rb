require 'httparty'
#
class FirebaseLib
  def self.verification(token)
    firebase_api_key = Rails.application.credentials.dig(Rails.env.to_sym, :firebase, :api_key)
    url = "https://www.googleapis.com/identitytoolkit/v3/relyingparty/getAccountInfo?key=#{firebase_api_key}"
    headers = {
      'Content-Type' => 'application/json'
    }
    body = {
      'idToken' => token
    }.to_json

    firebase_verification_call = HTTParty.post(url, headers: headers, body: body)

    unless firebase_verification_call.response.code == '200'
      raise StandardError, firebase_verification_call.parsed_response['error']
    end

    firebase_verification_call.parsed_response
  end
end
