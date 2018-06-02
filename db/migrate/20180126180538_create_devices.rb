class CreateDevices < ActiveRecord::Migration[5.1]
	def change
		create_table :devices do |t|
			t.string :token, null: false
			t.integer :platform
			t.references :user
			t.timestamps
		end

		add_index :devices, :token, unique: true
		add_foreign_key :devices, :users, column: :user_id, on_delete: :cascade
	end
end
