class AddPostulantMetrics < ActiveRecord::Migration[5.1]
  def change
    add_column :postulants, :platform, :integer, null: false
    add_column :postulants, :languaje, :integer, null: false
    add_column :postulants, :seniority, :integer, null: false
  end
end
