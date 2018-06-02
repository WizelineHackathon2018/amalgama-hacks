require 'rails_helper'

RSpec.describe User, type: :model do
	it { is_expected.to respond_to :first_name }
	it { is_expected.to respond_to :last_name }
	it { is_expected.to respond_to :facebook_id }
	it { is_expected.to respond_to :email }
	it { is_expected.to respond_to :phone }
	it { is_expected.to respond_to :avatar }
	it { is_expected.to respond_to :document_number }

	describe 'create user' do
		let( :user ) {  create :user }

		context 'with correct email and password' do
			it 'the creation is valid' do
				expect(
					User.create email: 'valid@app.com', password: 'password'
				).to be_valid
			end
		end

		context 'with incorrect email' do
			it 'the creation is invalid' do
				expect(
					User.create email: 'invalid-app.com', password: 'password'
				).not_to be_valid
			end
		end

		context 'with incorrect password' do
			it 'the creation is valid' do
				expect(
					User.create email: 'valid@app.com', password: nil
				).to be_valid
			end
		end

		context 'with invalid email' do
			it 'the creation is invalid' do
				expect(
					User.create email: 'valid', password: 'password'
				).not_to be_valid
			end
		end

		context 'with invalid document_number' do
			it 'the creation is invalid' do
				expect(
					User.create(
						email: 'valid@app.com', password: 'password', document_number: 'AAA'
					)
				).not_to be_valid
			end
		end
	end
end
