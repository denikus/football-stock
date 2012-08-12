class ProductImage < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :image
  attr_accessor :image_file_name
  has_attached_file :image
  belongs_to :product
end
