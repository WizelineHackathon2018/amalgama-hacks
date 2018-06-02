require 'rails_helper'
require 'shared_examples/for_controllers'
require 'shared_examples/for_models'
require 'contexts/for_controllers'

RSpec.shared_context 'get user' do
	before { get :show, params: { id: "me" } }
end

RSpec.describe Api::V1::UsersController, type: :controller do
	include_examples 'create user', :user

	describe 'Get user' do
		context 'without token' do
			include_context 'get user'
			include_examples 'expect unauthorized response'
		end

		context 'with token' do
			include_context 'stub doorkeeper'

			include_context 'get user'
			include_examples 'expect successful response'
		end
	end
end
