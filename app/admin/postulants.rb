ActiveAdmin.register Postulant do
	menu priority: 5

	permit_params :name, :avatar

	config.per_page = 25


	action_item :view, only: :show do
		link_to I18n.t('active_admin.back'), collection_path
	end

	index download_links: [:csv] do
		selectable_column
		id_column
		column :name
		column :availability
		column :english
		column :gender
		actions
	end

	form do |f|
		f.inputs do
			f.semantic_errors *f.object.errors.keys
			f.input :name
			f.input :avatar, as: :file, hint: image_tag( f.object.avatar.url :thumb )
		end
		f.actions
	end

	show do |postulant|
		attributes_table do
			row :name
			row :avatar do
				image_tag( postulant.avatar.url :medium ) if postulant.avatar.present?
			end
		end
	end

end
