require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
	class Application < Rails::Application
		# Initialize configuration defaults for originally generated Rails version.
		config.load_defaults 5.1

		config.web_console.development_only = false

		# Settings in config/environments/* take precedence over those specified here.
		# Application configuration should go into files in config/initializers
		# -- all .rb files in that directory are automatically loaded.

		config.autoload_paths << Rails.root.join( 'app', 'interactors' )
		config.autoload_paths << Rails.root.join( 'app', 'services' )
		config.autoload_paths << Rails.root.join( 'app', 'errors' )
		config.autoload_paths << Rails.root.join( 'app', 'validators' )
		config.autoload_paths << Rails.root.join( 'app', 'assets' )
		config.autoload_paths << Rails.root.join( 'app', 'services', 'facebook_api_log_in' )
		config.autoload_paths << Rails.root.join( 'lib' )
	end
end
