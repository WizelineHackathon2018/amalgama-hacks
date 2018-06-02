require 'shared_examples/for_models'

RSpec.shared_context 'stub doorkeeper' do
	let( :token ) { double :acceptable? => true }
	include_examples 'create user', :user

	before do
		allow( controller ).to receive( :doorkeeper_token ) { token }
		allow( controller ).to receive( :current_user ) { user }
	end
end
