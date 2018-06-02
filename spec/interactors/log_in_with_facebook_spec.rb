require 'rails_helper'
require 'contexts/for_services'
require 'shared_examples/for_models'

RSpec.shared_examples 'the log in is valid' do
	it 'response with user' do
		user_response = LogInWithFacebook.get_user_with(
			auth_code: auth_code, device_token: token, platform: platform
		)
		expect( user_response.email ).to eq user.email
		expect( user_response.first_name ).to eq user.first_name
		expect( user_response.last_name ).to eq user.last_name
		expect( user_response.facebook_id ).to eq user.facebook_id
		expect( user_response.avatar ).to eq user.avatar
	end
end

RSpec.describe LogInWithFacebook do

	let( :auth_code ) { Settings.facebook.auth_code }
	let( :facebook_id ) { 10214312682281777 }
	let( :last_name ) { 'Fulanito' }
	let( :first_name ) { 'Cosme' }
	let( :email ) { 'test@app.com' }
	let( :avatar_url ) { "#{Rails.root}/spec/images/favicon.png" }
	let( :token ) { 'valid_token' }
	let( :platform ) { :android }
	let( :user ) {
		User.new(
			facebook_id: facebook_id,
			last_name: last_name,
			first_name: first_name,
			email: email,
			avatar: avatar_url
		)
	}

	let( :response_image_body ){ 
		{
			"data" => { "url" => avatar_url }
		}.to_json
	}

	context 'with correct auth code' do
		let( :response_body ){ 
			{
				id: facebook_id,
				name: "Cosme Fulanito",
				email: email,
				first_name: first_name,
				last_name: last_name,
				gender: "male"
			}.to_json
		}

		include_context "stub facebook request", 200

		context 'with device_token and platform' do
			include_examples 'the log in is valid'
		end

		context 'without device_token' do
			let( :token ) { nil }
			include_examples 'the log in is valid'
		end

		context 'without device_token' do
			let( :platform ) { nil }
			include_examples 'the log in is valid'
		end
	end

	context "when facebook don't return email" do
		let( :response_body ){ 
			{
				id: facebook_id,
				name: "Cosme Fulanito",
				email: "",
				first_name: first_name,
				last_name: last_name,
				gender: "male"
			}.to_json
		}
		include_context "stub facebook request", 200

		it 'response with user without email' do
			user_response = LogInWithFacebook.get_user_with(
				auth_code: auth_code, device_token: token, platform: platform
			)
			expect( user_response.email ).to eq "#{facebook_id}@change-me.com"
			expect( user_response.first_name ).to eq user.first_name
			expect( user_response.last_name ).to eq user.last_name
			expect( user_response.facebook_id ).to eq user.facebook_id
			expect( user_response.avatar ).to eq user.avatar
		end
	end

	context 'with incorrect auth code' do
		let( :auth_code ) { "" }
		let( :response ) {
			{
				error: {
					message: "Facebook Graph Api error"
				}
			}
		}
		let( :response_body ){ response.to_json }

		include_context "stub facebook request", 200

		it { 
			expect{ 
				LogInWithFacebook.get_user_with(
					auth_code: auth_code, device_token: token, platform: platform
				)
			}.to raise_exception Error
		}
	end

	context 'with incorrect email format' do
		let( :response ) {
			{
				error: {
					message: "Facebook Graph Api error"
				}
			}
		}
		let( :response_body ){ 
			{
				id: facebook_id,
				name: "Cosme Fulanito",
				email: "email-bad.com",
				first_name: first_name,
				last_name: last_name,
				gender: "male"
			}.to_json
		}

		include_context "stub facebook request", 200

		it { 
			expect{ 
				LogInWithFacebook.get_user_with(
					auth_code: auth_code, device_token: token, platform: platform
				)
			}.to raise_exception UnprocessableError
		}
	end
end
