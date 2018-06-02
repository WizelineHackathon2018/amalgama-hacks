require "rails_helper"

RSpec.describe UserIsValid do
	before {
		class Example < Interactor
			validates_with UserIsValid
		end
	}
	context 'check validation' do
		let( :user ) { build :user, email: nil }
		let( :arguments_example ) { { user: user } }

		let( :interactor ) { Example.new arguments_example }

		it {
			expect{ interactor.arguments }.to raise_exception Error
		}
	end
end