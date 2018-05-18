# save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start 'rails' do
  add_filter('/bin')
  add_filter('/app/admin')
  add_filter('/app/channels')
  add_filter('/app/controllers/root_controller.rb')
  add_filter('/app/lib')
  add_filter('/app/models/admin_user.rb')
  add_filter('/app/models/google_cloud.rb')
  add_filter('/app/serializers/api/error_serializer.rb')
  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Serializers', 'app/serializers'
end
