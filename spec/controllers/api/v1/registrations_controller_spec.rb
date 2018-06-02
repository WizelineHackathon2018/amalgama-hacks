require 'rails_helper'
require 'shared_examples/for_controllers'
require 'shared_examples/for_models'
require 'contexts/for_controllers'

RSpec.shared_context 'sign up user' do
	before {
		post :create, params: {
			user: {
				email: email, password: password, password_confirmation: password_confirmation
			}
		}
	}
end

RSpec.describe Api::V1::RegistrationsController, type: :controller do
	before(:each) do
		@request.env["devise.mapping"] = Devise.mappings[:user]
	end

	describe 'Sign up user' do
		let( :email ) { 'me@example.com' }
		let( :password ) { 'password' }
		let( :password_confirmation ) { password }

		context 'with correct params' do
			include_context 'sign up user'
			include_examples 'expect successful response'
		end

		context 'with invalid email' do
			let( :email ) { nil }

			include_context 'sign up user'
			include_examples 'expect bad request response'
		end

		context 'with invalid password' do
			let( :password ) { nil }

			include_context 'sign up user'
			include_examples 'expect bad request response'
		end

		context 'with invalid password_confirmation' do
			let( :password_confirmation ) { 'invalid password' }

			include_context 'sign up user'
			include_examples 'expect bad request response'
		end
	end
end
