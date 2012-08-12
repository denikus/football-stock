class ProductsController < ApplicationController
  def index

  end

  def new
    @product = Product.new
    ap @product.errors
  end

  def create
    @product = Product.new(params[:product])
    if @product.valid?
      @product.save!
      redirect_to :action => "show", :id => @product.id
    else
      render :action => "new"
    end
    #redirect_to :action => "show"
  end

  def show
    @product = Product.find(params[:id])
  end
end