class StoreController < ApplicationController
  def index
    @products = Product.find_product_for_sale
  end

  def add_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @cart.add_product(product)
  end

  def clear_cart
    @cart = find_cart
    @cart.clear
    redirect_to :action => 'index'
  end

  private

  def find_cart
    session[:cart] ||= Cart.new
  end

end
