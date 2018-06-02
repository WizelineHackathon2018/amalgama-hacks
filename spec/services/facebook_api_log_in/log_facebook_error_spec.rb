require 'rails_helper'

RSpec.describe LogFacebookError do
	context 'with correct params' do
		let( :auth_code ) { "qwerty" }
		let( :platform ) { "android" }
		let( :error_message ) { "HI" }

		it {
			expect(
				LogFacebookError.with(
					auth_code: auth_code, platform: platform, error_message: error_message
				)
			).to eq true
		}
	end

	context 'with null params' do
		let( :auth_code ) { nil }
		let( :platform ) { nil }
		let( :error_message ) { nil }

		it {
			expect(
				LogFacebookError.with(
					auth_code: auth_code, platform: platform, error_message: error_message
				)
			).to eq true
		}
	end
end