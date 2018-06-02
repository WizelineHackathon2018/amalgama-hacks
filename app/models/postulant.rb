class Postulant < ApplicationRecord
	validates :name, presence: true

	enum availability: { unavailable: 0, available: 1 }
	enum english: { no: 0, yes: 1 }
	enum gender: { female: 0, male: 1 }

end
