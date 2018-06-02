require 'rails_helper'

RSpec.describe NotFoundError do
	let( :error_type ) { "not_found" }
	let( :error_message ) { "error_message" }
	let( :error ) { NotFoundError.new error_type, error_message }

	context 'new NotFoundError' do
		it {
			expect( error.http_status_code ).to eq 404
		}
		it {
			expect( error.error ).to eq error_type
		}
		it {
			expect( error.error_message ).to eq error_message
		}
		it {
			expect( error.as_http_hash ).to eq(
				{
					exception: error,
					status: error.http_status_code
				}
			)
		}
	end
end