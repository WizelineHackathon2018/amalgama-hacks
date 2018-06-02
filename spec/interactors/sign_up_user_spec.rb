require 'rails_helper'
require 'shared_examples/for_models'

RSpec.describe SignUpUser do
	let( :password ) { 'password' }
	let( :user ) { build :user }

	context 'with correct params' do
		it 'return user' do
			response = SignUpUser.with(
				user: user, email: user.email, password: password, password_confirmation: password
			)
			expect( response.active_for_authentication? ).to eq true
		end
	end

	context 'when email has already been taken' do
		let( :duplicate_user ) { create :user }
		let( :user ) { build :user, email: duplicate_user.email }
		it {
			expect {
				SignUpUser.with(
					user: user,
					email: duplicate_user.email,
					password: password,
					password_confirmation: password
				)
			}.to raise_exception Error
		}
	end

	context 'without password' do
		it {
			expect {
				SignUpUser.with(
					user: user,
					email: user.email,
					password: nil,
					password_confirmation: password
				)
			}.to raise_exception Error
		}
	end

	context 'without email' do
		it {
			expect {
				SignUpUser.with(
					user: user,
					email: nil,
					password: password,
					password_confirmation: password
				)
			}.to raise_exception Error
		}
	end

	context 'with invalid password_confirmation' do
		it {
			expect {
				SignUpUser.with(
					user: user,
					email: nil,
					password: password,
					password_confirmation: 'invalid password'
				)
			}.to raise_exception Error
		}
	end
end
