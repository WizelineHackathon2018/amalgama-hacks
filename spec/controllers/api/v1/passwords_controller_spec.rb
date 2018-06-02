require 'rails_helper'
require 'shared_examples/for_controllers'
require 'shared_examples/for_models'
require 'contexts/for_controllers'

RSpec.shared_context 'forgot_password' do
	before { post :forgot_password, params: { user_id: id } }
end

RSpec.shared_context 'update' do
	before { post :update, params: {
			user: {
				reset_password_token: @reset_password_token,
				password: password,
				password_confirmation: password_confirmation
			}
		}
	}
end

RSpec.describe Api::V1::PasswordsController, type: :controller do
	describe '#forgot_password' do
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:user]
		end
		let( :user ) { create :user }
		let( :id ) { user.id }

		context 'with correct params' do
			include_context 'forgot_password'
			include_examples 'expect successful response'
		end

		context 'with invalid id' do
			let( :id ) { 1231231 }

			include_context 'forgot_password'
			include_examples 'expect not found response'
		end
	end

	describe '#update' do
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:user]
			user = create :user
			@reset_password_token = user.send_reset_password_instructions
		end

		let( :password ) { 'password' }
		let( :password_confirmation ) { password }

		context 'with correct params' do
			include_context 'update'
			include_examples 'expect successful response'
		end

		context 'with correct params' do
			let( :password ) { 'pass' }
			include_context 'update'
			include_examples 'expect bad request response'
		end
	end
end
