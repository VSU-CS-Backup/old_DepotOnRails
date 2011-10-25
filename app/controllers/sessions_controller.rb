#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
#---
# Excerpted from "Agile Web Development with Rails, 4rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
    @cart = current_cart
  end

  def create
    @cart = current_cart
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      respond_to do |format|
        format.html {redirect_to login_url, :alert => "Invalid user/password combination" }
        format.xml  { render :text => "Invalid user/password combination" }
      end
      
    end
  end

  def destroy
    @cart = current_cart
    session[:user_id] = nil

    respond_to do |format|
        format.html {redirect_to store_url, :notice => "Logged out" }
        format.xml  { render :text => "Logged out" }
      end
  end

end
