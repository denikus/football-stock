# -*- encoding : utf-8 -*-
class Product < ActiveRecord::Base
  # attr_accessible :title, :body
  STATUSES = {:used =>"БУ", :new =>"Новый"}
end
