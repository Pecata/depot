class StoreController < ApplicationController
  def index
    @products = Product.find_product_for_sale
    @cart = find_cart
  end

  def add_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      redirect_to("Invalid product.")
    else
      @cart = find_cart
      @cart.add_product(product)
      redirect
    end
  end

  def clear_cart
    session[:cart] = nil
    redirect("Your cart is currently empty.")
  end

  private

  def redirect(message=nil)
    flash[:notice] = message if message
    redirect_to :action => 'index'
  end

  def find_cart
    session[:cart] ||= Cart.new
  end

end
