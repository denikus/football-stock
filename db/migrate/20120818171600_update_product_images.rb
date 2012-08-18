class UpdateProductImages < ActiveRecord::Migration
  def up
    remove_column :products, :product_image_file_name
    remove_column :products, :product_image_content_type
    remove_column :products, :product_image_file_size
    remove_column :products, :product_image_updated_at
    change_table :product_images do |t|
      t.string :image_file_name, :default => nil
      t.string :image_content_type, :default => nil
      t.integer :image_file_size, :default => nil
      t.datetime :image_updated_at, :default => nil
    end
  end

  def down

  end
end
