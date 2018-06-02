class AddFieldsToUser < ActiveRecord::Migration[5.1]
	def change
		add_column :users, :facebook_id, :integer, :limit => 8
		add_column :users, :avatar, :string
		add_column :users, :first_name, :string
		add_column :users, :last_name, :string
		add_column :users, :phone, :string
		add_column :users, :document_number, :integer

		add_index :users, :document_number, unique: true
		add_index :users, :facebook_id, unique: true
	end
end
