class MainController < ApplicationController
  def index
    page = params[:page] || 1
    per_page||=2
    @products = Product.paginate(:page => page, :per_page => per_page)
  end
end
