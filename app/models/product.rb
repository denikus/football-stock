# -*- encoding : utf-8 -*-
class Product < ActiveRecord::Base
  validates :name, :price, :status, :presence => true
  validates :email, :presence => true, :if => "phone.blank?"
  validates :phone, :presence => true, :if => "email.blank?"
  validates :price, :numericality => { :only_integer => true, :greater_than => 0}

  attr_accessible :name, :status, :price, :description, :phone, :email, :product_images, :product_images_attributes
  STATUSES = {:used =>"БУ", :new =>"Новый"}

  has_many :product_images
  accepts_nested_attributes_for :product_images
end
