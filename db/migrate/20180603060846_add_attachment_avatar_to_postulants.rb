class AddAttachmentAvatarToPostulants < ActiveRecord::Migration[5.1]
  def self.up
    change_table :postulants do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :postulants, :avatar
  end
end
