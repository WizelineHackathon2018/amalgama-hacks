source 'https://rubygems.org'

git_source(:github) do |repo_name|
	repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
	"https://github.com/#{repo_name}.git"
end

gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.6'

### For Web Development
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'

## See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'turbolinks', '~> 5'

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem "sentry-raven" # URL: https://docs.sentry.io/clients/ruby/install/

# gem 'capybara', '~> 2.13', group: :development
# gem 'selenium-webdriver', group: :development

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0' # url: https://github.com/redis/redis-rb

# gem 'sidekiq' # url: https://github.com/mperham/sidekiq
gem 'sidekiq-scheduler' # url: https://github.com/moove-it/sidekiq-scheduler

# url: https://github.com/mperham/sidekiq
gem 'sidekiq'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# url: https://github.com/rails-api/active_model_serializers
gem 'active_model_serializers', '~> 0.10.0'

# For configuration in connfig/setting
gem 'config'

# Active admin, url: https://github.com/activeadmin/activeadmin
gem 'activeadmin', github: 'activeadmin'

# url: https://github.com/vigetlabs/active_material
gem "active_material", github: "vigetlabs/active_material"

# url: https://github.com/ball-hayden/responsive_active_admin
gem 'responsive_active_admin'

# url: https://github.com/rstgroup/active_skin
gem 'active_skin'

# url: https://github.com/activeadmin-plugins/active_admin_datetimepicker
gem 'active_admin_datetimepicker'

# Internalization, url: https://github.com/svenfuchs/rails-i18n
gem 'rails-i18n', '~> 5.0.0' # For 5.0.x and 5.1.x

# For User roles, url: https://github.com/RolifyCommunity/rolify
gem 'rolify'

# For admin authorizations, url: https://github.com/CanCanCommunity/cancancan
gem 'cancancan', '~> 1.10'

gem 'devise' # For user model, url: https://github.com/plataformatec/devise
gem 'devise-i18n' # url: https://github.com/tigrish/devise-i18n

gem 'doorkeeper' # url: https://github.com/doorkeeper-gem/doorkeeper
gem 'doorkeeper-grants_assertion', git: 'https://github.com/Badiapp/doorkeeper-grants_assertion'
gem 'doorkeeper-i18n'

# Auto schema in models, url: https://github.com/ctran/annotate_models
gem 'annotate'

gem 'paperclip', '~> 5.0.0' # url: https://github.com/thoughtbot/paperclip

gem 'rubocop', require: false
gem 'rubycritic', require: false
gem 'web-console', '>= 3.3.0'

gem 'mysql2', '~> 0.3.18'
gem 'better_errors' # url: https://github.com/charliesome/better_errors

# Use Capistrano for deployment
group :development do
  gem 'capistrano', '3.10.0', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'

end

group :development do
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'binding_of_caller'
end

group :test do
  gem 'simplecov', require: false
  gem 'webmock'
  gem 'rspec-sidekiq'
end

group :development, :test do
  gem 'byebug', platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'rspec'
  gem 'rspec-mocks'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 3.1'
end

gem 'listen', '>= 3.0.5', '< 3.2'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
