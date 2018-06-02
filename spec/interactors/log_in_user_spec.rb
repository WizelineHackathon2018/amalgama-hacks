require 'rails_helper'
require 'shared_examples/for_models'

RSpec.shared_examples 'the log in with email and pass is valid' do
	it 'response with user' do
		expect(
			LogInUser.with(
				email: user.email,
				password: user.password,
				device_token: device_token,
				platform: platform
			)
		).to eq user
	end
end

RSpec.describe LogInUser do
	include_examples 'create user', :user
	let( :device_token ) { 'valid_token' }
	let( :platform ) { :android }

	context 'with correct params' do
		include_examples 'the log in with email and pass is valid'
	end

	context 'without device_token' do
		let( :device_token ) { nil }
		include_examples 'the log in with email and pass is valid'
	end

	context 'without device_token' do
		let( :platform ) { nil }
		include_examples 'the log in with email and pass is valid'
	end

	context 'without password' do
		it {
			expect {
				LogInUser.with(
					email: user.email,
					password: nil,
					device_token: device_token,
					platform: platform
				)
			}.to raise_exception Error
		}
	end

	context 'without email' do
		it {
			expect {
				LogInUser.with(
					email: nil,
					password: user.password,
					device_token: device_token,
					platform: platform
					)
				}.to raise_exception Error
			}
	end

	context 'with incorrect password' do
		it {
			expect(
				LogInUser.with(
					email: user.email,
					password: 'invalid_password',
					device_token: device_token,
					platform: platform
				)
			).to eq nil
		}
	end
end
