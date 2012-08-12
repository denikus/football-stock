class ProductsController < ApplicationController
  def index

  end

  def new
    @product = Product.new
    @product.product_images.build
  end

  def create
    ap params
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