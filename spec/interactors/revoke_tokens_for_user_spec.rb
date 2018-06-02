require 'rails_helper'

RSpec.shared_examples 'number of revoked access tokens is correct' do |access_tokens|
	it {
		expect(
			Doorkeeper::AccessToken.where(
				resource_owner_id: user.id
			).where.not( revoked_at: nil ).count
		).to be access_tokens
	}
end

RSpec.shared_context 'create access token for RevokeTokensForUser' do |token|
	before { Doorkeeper::AccessToken.create! resource_owner_id: user.id, token: token }
end

RSpec.shared_context 'revoke tokens for user' do
	before { RevokeTokensForUser.with user: user }
end

RSpec.shared_examples 'revokes all access tokens' do
	it {
		expect(
			Doorkeeper::AccessToken.where( resource_owner_id: user.id, revoked_at: nil ).count
		).to be 0
	}
end

RSpec.describe RevokeTokensForUser do
	let!( :user ) { create :user }

	context 'without access tokens' do
		include_context 'revoke tokens for user'
		include_examples 'number of revoked access tokens is correct', 0
		include_examples 'revokes all access tokens'
	end

	context 'with one access token' do
		include_context 'create access token for RevokeTokensForUser', 'token'
		include_context 'revoke tokens for user'
		include_examples 'number of revoked access tokens is correct', 1
		include_examples 'revokes all access tokens'
	end

	context 'with two access tokens' do
		include_context 'create access token for RevokeTokensForUser', 'token'
		include_context 'create access token for RevokeTokensForUser', 'another_token'
		include_context 'revoke tokens for user'
		include_examples 'number of revoked access tokens is correct', 2
		include_examples 'revokes all access tokens'
	end

	context 'with one revoked token and one unrevoked token' do
		before {
			Doorkeeper::AccessToken.create!(
				resource_owner_id: user.id, token: 'another_token', revoked_at: Time.zone.now
			)
		}
		include_context 'create access token for RevokeTokensForUser', 'token'
		include_context 'revoke tokens for user'
		include_examples 'number of revoked access tokens is correct', 2
		include_examples 'revokes all access tokens'
	end

	context 'when other user has unrevoked access tokens' do
		let!( :another_user ) { create :user }
		before {
			Doorkeeper::AccessToken.create!(
				resource_owner_id: another_user.id, token: 'another_token'
			)
		}
		include_context 'create access token for RevokeTokensForUser', 'token'
		include_context 'revoke tokens for user'
		include_examples 'number of revoked access tokens is correct', 1
		include_examples 'revokes all access tokens'
		it {
			expect(
				Doorkeeper::AccessToken.where(
					resource_owner_id: another_user.id, revoked_at: nil
				).count
			).to be 1
		}
	end

	context 'without user' do
		it { expect { RevokeTokensForUser.with user: nil }.to raise_exception Error }
	end
end