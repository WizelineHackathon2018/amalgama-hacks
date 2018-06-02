require 'rails_helper'

RSpec.describe Device, type: :model do
	it { is_expected.to respond_to :token }
	it { is_expected.to belong_to :user }
	it { expect define_enum_for( :platform ).with [:andorid, :ios] }

	describe '#create!' do
		context 'with correct params' do
			let( :valid_device ) { build :device }
			it { expect( valid_device ).to be_valid }

			context 'when platform is android' do
				let( :valid_device ) { build :device, :for_android }
				it { expect( valid_device ).to be_valid }
			end
		end

		context 'with invalid platform' do
			it { expect { build :device_with_invalid_platform }.to raise_exception ArgumentError }
		end

		context 'without token' do
			let( :device_without_token ) { build :device_without_token }
			it { expect( device_without_token ).not_to be_valid }
		end

		context 'without user' do
			let( :device_without_user ) { build :device_without_user }
			it { expect( device_without_user ).not_to be_valid }
		end

		context 'with duplicated token' do
			let( :valid_device ) { create :device }
			let( :device_with_duplicated_token ) { build :device, token: valid_device.token }

			it { expect( device_with_duplicated_token ).not_to be_valid }
		end
	end
end
