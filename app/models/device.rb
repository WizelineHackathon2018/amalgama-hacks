# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  token      :string           not null
#  platform   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_devices_on_token    (token) UNIQUE
#  index_devices_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#

class Device < ApplicationRecord
	belongs_to :user

	validates :token, uniqueness: true, presence: true
	validates :platform, :user, presence: true

	enum platform: { ios: 0, android: 1 }
end
