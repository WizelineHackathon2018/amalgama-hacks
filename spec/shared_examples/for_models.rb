RSpec.shared_examples 'create user' do |role|
	let( :user ) { create :user }
	before { user.add_role role }
end

RSpec.shared_examples 'create user with device' do
	include_examples 'create user', :user
	let( :device ) { create :device, user: user }
end
