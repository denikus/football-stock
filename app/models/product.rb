# -*- encoding : utf-8 -*-
class Product < ActiveRecord::Base
  attr_accessible :name, :status, :price, :description, :phone, :email
  STATUSES = {:used =>"БУ", :new =>"Новый"}
end
