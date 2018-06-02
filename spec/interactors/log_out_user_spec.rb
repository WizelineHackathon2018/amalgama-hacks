require 'rails_helper'
require 'shared_examples/for_models'

RSpec.shared_examples 'revokes the access token' do
	it 'revokes the access token' do
		expect( access_token.revoked_at ).to_not be nil
	end
end

RSpec.shared_context 'log out user' do
	before { LogOutUser.with token: token, tokens_controller: tokens_controller }
end

RSpec.shared_examples 'destroys user device' do
	it 'destroys user device' do
		expect( Device.count ).to be 0
	end
end

RSpec.shared_context 'create access token' do
	before { Doorkeeper::AccessToken.create! resource_owner_id: user.id }
end

RSpec.shared_examples 'log out user raise Error' do |error_type|
	it {
		expect {
			LogOutUser.with token: token, tokens_controller: tokens_controller
		}.to raise_exception error_type
	}
end

RSpec.describe LogOutUser do
	include_examples 'create user', :user
	let( :access_token ) { Doorkeeper::AccessToken.last }
	let( :token ) { access_token.token }
	let( :tokens_controller ) { double }

	context 'with valid params' do
		include_context 'create access token'
		before do
			allow( tokens_controller ).to receive( :revoke_user_token ) {
				access_token.update! revoked_at: Time.zone.now
			}
		end

		context 'with device' do
			include_context 'log out user'
			include_examples 'revokes the access token'
			include_examples 'destroys user device'
		end

		context 'with device' do
			let!(:device) { create :device, user: user }

			include_context 'log out user'
			include_examples 'revokes the access token'
			include_examples 'destroys user device'
		end
	end

	context 'without token' do
		let( :token ) { nil }
		include_examples 'log out user raise Error', Error
	end

	context 'with blank token' do
		let( :token ) { '' }
		include_examples 'log out user raise Error', Error
	end

	context 'when the access token doesn\'t exist' do
		let( :access_token ) { nil }
		let( :token ) { 'token' }
		include_examples 'log out user raise Error', Error
	end

	context 'when the access token was already revoked' do
		before do
			Doorkeeper::AccessToken.create!(
				resource_owner_id: user.id, revoked_at: ( Time.zone.now - 2.days )
			)
		end

		include_examples 'log out user raise Error', ForbiddenError
	end

	context 'without tokens controller' do
		let( :tokens_controller ) { nil }
		include_context 'create access token'
		include_examples 'log out user raise Error', Error
	end
end
