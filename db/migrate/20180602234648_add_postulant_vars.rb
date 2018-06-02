class AddPostulantVars < ActiveRecord::Migration[5.1]
  def change
    add_column :postulants, :availability, :integer, null: false
    add_column :postulants, :english, :integer, null: false
    add_column :postulants, :gender, :integer, null: false
  end
end
