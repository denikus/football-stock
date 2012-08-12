require 'spec_helper'

describe Product do
  it "shouldn't create product without name" do
    product = Product.new({:price => 12, :description => "test", :email =>"denix@front.ru"})
    product.should_not be_valid
  end

  it "shouldn't create product without price" do
    product = Product.new({:name => "product name", :description => "test", :email =>"denix@front.ru"})
    product.should_not be_valid
  end

  it "shouldn't create product without email or phone" do
    product = Product.new({:price => 12, :description => "test", :name => "name", :email => "denix@front.ru"})
    product.should be_valid
  end

  it "price should be numerical and greater than zero" do
    product = Product.new({:price => "12w", :description => "test", :name => "name", :email => "denix@front.ru"})
    product.should_not be_valid

    product = Product.new({:price => "0", :description => "test", :name => "name", :email => "denix@front.ru"})
    product.should_not be_valid

    product = Product.new({:price => "10", :description => "test", :name => "name", :email => "denix@front.ru"})
    product.should be_valid
  end

end
