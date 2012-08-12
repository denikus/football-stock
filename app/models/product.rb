# -*- encoding : utf-8 -*-
class Product < ActiveRecord::Base
  validates :name, :price, :status, :presence => true
  validates :email, :presence => true, :if => "phone.blank?"
  validates :phone, :presence => true, :if => "email.blank?"
  validates :price, :numericality => { :only_integer => true, :greater_than => 0}

  attr_accessible :name, :status, :price, :description, :phone, :email
  STATUSES = {:used =>"БУ", :new =>"Новый"}
end
