require 'rails_helper'

RSpec.shared_examples 'creates or updates the device raise Error' do
	it {
		expect {
			CreateOrUpdateDevice.with user: user, token: token, platform: platform
		}.to raise_exception Error
	}
end

RSpec.shared_context 'creates or updates the device' do
	before { @device = CreateOrUpdateDevice.with user: user, token: token, platform: platform }
end

RSpec.shared_examples 'the device has the correct params' do
	it 'has the correct params' do
		expect( @device ).to have_attributes(
			token: token,
			platform: platform.to_s,
			user: user
		)
	end
end

RSpec.shared_examples 'creates only one device' do
	it 'creates only one device' do
		expect( Device.count ).to be 1
	end
end

RSpec.describe CreateOrUpdateDevice do
	let( :token ) { 'valid_token' }
	let( :platform ) { :ios }
	let!( :user ) { create :user }

	context 'with correct params' do
		include_context 'creates or updates the device'

		context 'with user' do
			include_examples 'the device has the correct params'
			include_examples 'creates only one device'

			context 'when the user updates his device' do
				let( :token ) { 'another_token' }
				let( :platform ) { :android }
				include_context 'creates or updates the device'

				include_examples 'the device has the correct params'
				include_examples 'creates only one device'
			end

			context 'when the user only updates his device token' do
				let( :token ) { 'another_token' }
				before {
					@device = CreateOrUpdateDevice.with user: user, token: token, platform: nil
				}

				include_examples 'the device has the correct params'
				include_examples 'creates only one device'
			end

			context 'when another user wants to use the same device' do
				let( :user2 ) { create :user }
				before { 
					@device = CreateOrUpdateDevice.with user: user2, token: token, platform: platform
				}
				include_context 'creates or updates the device'

				include_examples 'the device has the correct params'
				include_examples 'creates only one device'
			end
		end
	end

	context 'without user' do
		let( :user ) { nil }
		include_examples 'creates or updates the device raise Error'
	end

	context 'without token' do
		let( :token ) { nil }
		include_examples 'creates or updates the device raise Error'
	end

	context 'with invalid token' do
		let( :token ) { '' }
		include_examples 'creates or updates the device raise Error'
	end

	context 'without platform' do
		let( :platform ) { nil }
		include_examples 'creates or updates the device raise Error'
	end

	context 'with invalid platform' do
		let( :platform ) { '' }
		include_examples 'creates or updates the device raise Error'
	end
end