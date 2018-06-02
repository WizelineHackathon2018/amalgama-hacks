require 'rails_helper'
require 'contexts/for_services'

RSpec.shared_examples 'new facebook api' do
	before { @facebook_api = FacebookApi.new auth_code: auth_code, platform: 'android' }
end

RSpec.describe FacebookApi do
	let( :avatar_url ) { "#{Rails.root}/spec/images/favicon.png" }

	let( :response_image_body ) {
		{
			'data' => { 'url' => avatar_url }
		}.to_json
	}

	context 'with correct auth code' do
		let( :auth_code ) { Settings.facebook.auth_code }
		include_examples 'new facebook api'
		let( :response ) {
			{
				id: 10214312682281777,
				name: 'Cosme Fulanito',
				email: 'test@app.com',
				first_name: 'Cosme',
				last_name: 'Fulanito',
				gender: 'male',
				avatar_url: avatar_url
			}
		}

		let( :response_body ){ response.to_json }

		include_context 'stub facebook request', 200

		it 'response with user data' do
			expect( @facebook_api.get_user_data ).to eq JSON.parse response_body
		end
	end

	context 'with incorrect auth code' do
		let( :auth_code ) { '' }
		include_examples 'new facebook api'
		let( :response ) {
			{
				error: {
					message: 'Facebook Graph Api error'
				}
			}
		}
		let( :response_body ){ response.to_json }

		include_context 'stub facebook request', 400

		it { expect{ @facebook_api.get_user_data }.to raise_exception Error }
	end

	context 'with error in image request' do
		let( :auth_code ) { Settings.facebook.auth_code }
		include_examples 'new facebook api'
		let( :response ) {
			{
				error: {
					message: 'Facebook Graph Api error get image'
				}
			}
		}
		let( :response_body ){ response.to_json }

		include_context 'stub facebook request', 400

		it { expect{ @facebook_api.get_user_data }.to raise_exception Error }
	end
end
