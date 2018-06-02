require 'rails_helper'
require 'cancan/matchers'
require 'shared_examples/for_models'

RSpec.describe Ability do
	describe "User" do
		describe "abilities" do
			context "when is an app_user account" do
				include_examples 'create user', :user
				let(:ability){ Ability.new user }
				it{ 
					ability.cannot? :create, User.new
				}
			end

			context "when is an admin account" do
				include_examples 'create user', :admin
				let(:ability){ Ability.new user }
				it{ 
					ability.can? :create, User.new
				}
			end
		end
	end
end
