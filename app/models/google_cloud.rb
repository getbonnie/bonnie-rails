require 'singleton'
require 'google/cloud/firestore'
#
class GoogleCloud
  include Singleton
  include ActiveModel::Model

  GOOGLE_KEY_FILE = '/tmp/google.json'.freeze
  GOOGLE_KEY = {
    'type': 'service_account',
    'project_id': 'pew-app',
    'client_email': 'firebase-admin-sdk@pew-app.iam.gserviceaccount.com',
    'client_id': '100366764725588002430',
    'auth_uri': 'https://accounts.google.com/o/oauth2/auth',
    'token_uri': 'https://oauth2.googleapis.com/token',
    'auth_provider_x509_cert_url': 'https://www.googleapis.com/oauth2/v1/certs',
    'client_x509_cert_url': 'https://www.googleapis.com/robot/v1/metadata/x509/firebase-admin-sdk%40pew-app.iam.gserviceaccount.com'
  }.freeze

  attr_accessor :firestore

  def initialize
    google_key = GOOGLE_KEY.merge(
      private_key_id: Rails.application.credentials.dig(:google_cloud, :private_key_id),
      private_key: Rails.application.credentials.dig(:google_cloud, :private_key)
    ).to_json

    unless File.exist?(GOOGLE_KEY_FILE)
      f = File.open(GOOGLE_KEY_FILE, 'w')
      f.write(google_key)
      f.close
    end

    @firestore = Google::Cloud::Firestore.new(
      project_id: 'pew-app',
      credentials: GOOGLE_KEY_FILE
    )
  end

  def upload_cache
    return if Rails.env.test?

    data = Api::V1::GoogleCloud::CacheSerializer.new({}).as_json

    instance = @firestore.col('cache').doc('libraries')
    instance.set(data)
  end
end
