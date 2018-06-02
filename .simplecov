SimpleCov.start do
	coverage_dir 'reports/coverage'

	track_files '{app,lib}/**/*.rb'

	add_filter '/vendor/'
	add_filter '/bin/'
	add_filter '/db/'
	add_filter '/spec/'
	add_filter '/config/'
	add_filter '/lib/'

	# Ignore default files, uncomment if modified
	add_filter 'app/channels/application_cable/channel.rb'
	add_filter 'app/channels/application_cable/connection.rb'

	add_filter 'app/controllers/application_controller.rb'
	add_filter 'app/controllers/api/v1/api_controller.rb'
	add_filter 'app/controllers/concerns/api_handlers.rb'

	add_filter 'app/jobs/application_job.rb'

	add_filter 'app/admin/'

	add_filter 'app/models/application_record.rb'
	
	add_filter 'app/views/layout/application.html.erb'
	add_filter 'app/mailers/application_mailer.rb'
	add_filter 'app/views/layout/mailer.html.erb'
	add_filter 'app/views/layout/mailer.text.erb'

	add_group 'Models', '/app/models'
	add_group 'Interactors', '/app/interactors'
	add_group 'Services', '/app/services'
	add_group 'Controllers', '/app/controllers'
	add_group 'Serializers', '/app/serializers'
end if ENV['COVERAGE']
