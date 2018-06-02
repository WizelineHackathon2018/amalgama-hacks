ActiveAdmin.register User, as: 'Admins' do
	menu priority: 1, label: I18n.t('active_admin.page_views.admin_users'),
		if: proc { current_user.has_role? :admin }

	permit_params :email, :password, :password_confirmation

	filter :email
	filter :last_sign_in_at, label: 'Última vez conectado'

	config.per_page = 25

	before_create :set_admin_role
	controller do
		def scoped_collection
			User.with_role :admin
		end

		def set_admin_role( admin )
			admin.add_role :admin
		end
	end

	action_item :view, only: :show do
		link_to I18n.t('active_admin.back'), collection_path
	end

	index download_links: false do
		selectable_column
		id_column
		column :email
		column :last_sign_in_at
		actions
	end

	form do |f|
		f.inputs I18n.t('active_admin.form_title.admin_user') do
			f.semantic_errors *f.object.errors.keys
			f.input :email
			f.input :password
			f.input :password_confirmation
		end
		f.actions
	end

	show do |admin|
		attributes_table do
			row :email
			row :last_sign_in_at
		end
	end
end
