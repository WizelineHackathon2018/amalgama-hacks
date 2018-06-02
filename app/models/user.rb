# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  facebook_id            :integer
#  avatar                 :string
#  first_name             :string
#  last_name              :string
#  phone                  :string
#  document_number        :integer
#
# Indexes
#
#  index_users_on_document_number       (document_number) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_facebook_id           (facebook_id) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
	rolify

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable, :validatable

	has_one :device, dependent: :destroy

	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :document_number, uniqueness: true, allow_nil: true,
		numericality: { greater_than: 0, only_integer: true }

	protected

	def password_required?
		false
	end
end
