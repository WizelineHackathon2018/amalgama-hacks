require 'simplecov'
require 'webmock/rspec'
require 'sidekiq/testing'
require 'devise'

RSpec.configure do |config|
	config.expect_with :rspec do |expectations|
		expectations.include_chain_clauses_in_custom_matcher_descriptions = true
	end

	config.after( :suite ) do
		FileUtils.rm Rails.root.join( 'log', 'test.log' ) if Rails.env.test?
	end

	config.mock_with :rspec do |mocks|
		mocks.verify_partial_doubles = true
	end

	config.before(:each) do
		# WebMock.allow_net_connect!
		Sidekiq::Worker.clear_all
	end

	config.shared_context_metadata_behavior = :apply_to_host_groups
	config.filter_run_when_matching :focus
	config.example_status_persistence_file_path = 'spec/examples.txt'
	config.disable_monkey_patching!

	config.default_formatter = 'doc' if config.files_to_run.one?

	config.profile_examples = 10
	config.order = :random

	Kernel.srand config.seed
end
