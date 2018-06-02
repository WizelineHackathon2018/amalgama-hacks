ActiveAdmin.register User do
	menu priority: 1, label: I18n.t('active_admin.page_views.users'),
		if: proc { current_user.has_role? :admin }

	permit_params :email, :first_name, :last_name, :avatar, :phone, :document_number

	filter :email
	filter :first_name
	filter :last_name
	filter :document_number

	config.per_page = 25

	before_create :set_user_role
	controller do
		def scoped_collection
			User.with_role :user
		end

		def set_admin_role( user )
			user.add_role :user
		end
	end

	action_item :view, only: :show do
		link_to I18n.t('active_admin.back'), collection_path
	end
	index download_links: [:csv] do
		selectable_column
		id_column
		column :email
		column :first_name
		column :last_name
		column :document_number
		actions
	end

	form do |f|
		f.inputs I18n.t('active_admin.form_title.user') do
			f.semantic_errors *f.object.errors.keys
			f.input :email
			f.input :first_name
			f.input :last_name
			f.input :document_number
			f.input :phone
		end
		f.actions
	end

	show do |user|
		attributes_table do
			row :avatar do
				image_tag(
					user.avatar, class: 'user-thumb', size: "100"
				) if user.avatar.present?
			end
			row :email
			row :first_name
			row :last_name
			row :document_number
			row :address
			row :phone
			row :coins
		end
	end

	csv do
		column :id do |user|
			user.id
		end
		column :email do |user|
			user.email
		end
		column :first_name do |user|
			user.first_name
		end
		column :last_name do |user|
			user.last_name
		end
		column :document_number do |user|
			user.document_number
		end
		column :phone do |user|
			user.phone
		end
	end
end
