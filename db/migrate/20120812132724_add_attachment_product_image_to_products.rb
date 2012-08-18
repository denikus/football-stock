class AddAttachmentProductImageToProducts < ActiveRecord::Migration
  def self.up
    change_table :producs do |t|
      t.has_attached_file :product_image
    end
  end

  def self.down
    drop_attached_file :products, :product_image
  end
end
