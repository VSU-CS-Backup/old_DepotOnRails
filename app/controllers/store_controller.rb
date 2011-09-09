class StoreController < ApplicationController
  def index
    @cart = current_cart
    @products = Product.all
    @cart = current_cart
    
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] = session[:counter]+1
    end

  end

end
