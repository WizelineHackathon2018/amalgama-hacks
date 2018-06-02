class CreatePostulants < ActiveRecord::Migration[5.1]
	def change
		create_table :postulants do |t|

			t.string :name, null: false

			t.timestamps
		end
	end
end

