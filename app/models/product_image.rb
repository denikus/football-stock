class ProductImage < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :image

  #attr_accessor :image_file_name
  has_attached_file :image,
                    :path => ":rails_root/public:url",
                    :url => "/system/products/:product_id/:class/:id/:style/:filename",
                    :default_url => "/public/missing/:category_name.png",
                    :styles => { :medium => "200x200>", :thumb => "100x100#" }
  validates_attachment_size :image, :less_than => 5.megabytes

  belongs_to :product, :dependent =>:destroy

end
