source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

gem 'active_model_serializers', '~> 0.10.7'
gem 'activeadmin', '>= 1.4.3'
gem 'activeadmin-sortable'
gem 'acts_as_list'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.1.0', require: false
gem 'country_select'
gem 'devise', '~> 4.6.0'
gem 'fcm'
gem 'google-cloud-firestore'
gem 'httparty'
gem 'image_processing', '~> 1.2'
gem 'jwt', '~> 2.1.0'
gem 'kaminari'
gem 'meta-tags', '~> 2.9.0'
gem 'mini_magick', '~> 4.8.0'
gem 'phonelib'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cors', '~> 1.0.2'
gem 'rails', '~> 5.2.0'
gem 'sass-rails', '~> 5.0'
gem 'slim', '~> 3.0.9'
gem 'uglifier', '>= 2.7.2'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'fuubar'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
  gem 'webmock'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
