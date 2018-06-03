class Postulant < ApplicationRecord
	validates :name, presence: true

	has_attached_file :avatar,
		styles: { big: '800x800>', medium: '300x300>', thumb: '100x100>' },
		default_url: '/images/:style/amalgama.png'
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


	enum availability: { unavailable: 0, available: 1 }
	enum english: { no: 0, yes: 1 }
	enum gender: { female: 0, male: 1 }

end
