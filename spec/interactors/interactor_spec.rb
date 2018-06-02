require 'rails_helper'
require 'shared_examples/for_models'

RSpec.describe Interactor do
	before do
		class InteractorExample < Interactor
			validates :user, presence: true
		end
	end

	context 'check validation' do
		let( :arguments1 ) { { user: nil } }
		it { expect{ InteractorExample.new arguments1 }.to raise_exception Error }
	end

	context '#arguments' do
		include_examples 'create user', :user
		let( :arguments2 ) { { user: user } }

		it 'must has the same arguments' do
			expect( InteractorExample.new( arguments2 ).arguments ).to eq arguments2
		end
	end
end
