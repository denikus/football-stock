class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => ["index", "show"]

  def index

  end

  def new
    @product = Product.new
    3.times{@product.product_images.build}
    #@product.product_images.build
  end

  def create
    @product = Product.new(params[:product])
    if @product.valid?
      @product.save!
      redirect_to :action => "show", :id => @product.id
    else
      render :action => "new"
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end