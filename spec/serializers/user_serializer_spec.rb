require 'rails_helper'
require 'shared_examples/for_models'

RSpec.describe UserSerializer do
	include_examples 'create user', :user
	let( :user_serialization ) { 
		ActiveModelSerializers::SerializableResource.new( user, {} ).to_json 
	}

	it 'renders the user correctly' do
		expect( user_serialization ).to eq( 
			{
				id: user.id,
				email: user.email,
				first_name: user.first_name,
				last_name: user.last_name,
				document_number: user.document_number,
				avatar: user.avatar
			}.to_json
		)
	end
end
