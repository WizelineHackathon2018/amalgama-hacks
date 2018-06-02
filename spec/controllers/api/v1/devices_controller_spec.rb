require "rails_helper"
require 'shared_examples/for_controllers'
require 'shared_examples/for_models'
require 'contexts/for_controllers'

RSpec.shared_context 'update device token' do
	before { 
		patch :update_device_token,
		{ params: { user_id: "me", device_token: device_token, platform: platform } }
	}
end

RSpec.shared_examples 'device has correct attributes' do
	it 'has correct attributes' do
		expect( user.device ).to have_attributes(
			token: device_token,
			platform: platform_response.to_s,
			user: user
		)
	end
end

RSpec.describe Api::V1::DevicesController, type: :controller do
	include_examples 'create user with device'
	let( :device_token ) { device.token }
	let( :platform ) { device.platform }
	let( :platform_response ) { platform }

	describe '#PATCH update device token' do
		context 'without token' do
			include_context 'update device token'
			include_examples "expect unauthorized response"
		end

		context 'with user token' do
			include_context 'stub doorkeeper'

			context 'with correct params' do
				include_context 'update device token'
				include_examples 'expect successful response'
				include_examples 'device has correct attributes'
			end

			context 'with token only' do
				let( :platform ) { :android }
				include_context 'update device token'
				include_examples 'expect successful response'
				include_examples 'device has correct attributes'
			end

			context 'without device token' do
				let( :device_token ) { nil }
				include_context 'update device token'
				include_examples 'expect bad request response'
			end

			context 'when the user doesn\'t have device' do
				let!( :user ) { create :user }
				include_context 'update device token'
				include_examples 'expect successful response'
				include_examples 'device has correct attributes'
			end
		end
	end
end
