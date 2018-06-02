require 'rails_helper'

RSpec.describe ErrorRaiser do
	class FakeObject
		include ErrorRaiser
	end
	let( :error_message ) { 'default_error_message' }
	let(:fake_object) { FakeObject.new }

	describe '#error' do
		it {
			expect {
				fake_object.error :error_name, error_message, Error
			}.to raise_exception Error
		}
	end

	describe '#invalid' do
		it {
			expect {
				fake_object.invalid :error_name, error_message
			}.to raise_exception Error
		}
	end

	describe '#unauthorized' do
		it {
			expect {
				fake_object.unauthorized :error_name, error_message
			}.to raise_exception UnauthorizedError
		}
	end

	describe '#unprocessable' do
		it {
			expect {
				fake_object.unprocessable :error_name, error_message
			}.to raise_exception UnprocessableError
		}
	end

	describe '#forbidden' do
		it {
			expect {
				fake_object.forbidden :error_name, error_message
			}.to raise_exception ForbiddenError
		}
	end

	describe '#not_found' do
		it {
			expect {
				fake_object.not_found :error_name, error_message
			}.to raise_exception NotFoundError
		}
	end
end