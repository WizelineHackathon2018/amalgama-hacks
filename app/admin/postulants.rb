ActiveAdmin.register Postulant do
	menu priority: 5

	permit_params :name, :availability, :english, :gender, :platform,
		:seniority, :languaje, :avatar

	config.per_page = 25


	action_item :view, only: :show do
		link_to I18n.t('active_admin.back'), collection_path
	end

	index do
		selectable_column
		id_column
		column :name
		column :availability
		column :english
		column :gender
		column :avatar do |postulant|
			image_tag( postulant.avatar.url :thumb ) if postulant.avatar.present?
		end
		actions
	end

	form do |f|
		f.inputs do
			f.semantic_errors *f.object.errors.keys
			f.input :name
			f.input :availability
			f.input :english
			f.input :gender

			f.input :platform
			f.input :seniority
			f.input :languaje

			f.input :avatar, as: :file, hint: image_tag( f.object.avatar.url :thumb )
		end
		f.actions
	end

	show do |postulant|
		attributes_table do
			row :name
			row :availability
			row :english
			row :gender

			row :platform
			row :seniority
			row :languaje

			row :avatar do
				image_tag( postulant.avatar.url :medium ) if postulant.avatar.present?
			end
		end
	end

end
