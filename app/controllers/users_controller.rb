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
class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @cart=current_cart
    
    if (session[:user_id]!=nil)
      user = User.find(session[:user_id])
      if (user.name == 'admin')
         @users = User.order(:name)
      else
        @users = [user]
      end
    else
      @users = User.order(:name)
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @cart=current_cart
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @cart=current_cart
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @cart=current_cart
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @cart=current_cart
    # @user = User.new(params[:user])

     if (params[:user])
        @user = User.new(params[:user])
     else
        params[:user] = {:name=>params[:name], 
                            :password=>params[:password],   
                            :password_confirmation=>params[:password_confirmation], 
                            :address=>params[:address]
                            }
        @user = User.new(params[:user])
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to(users_url,
          :notice => "User #{@user.name} was successfully created.") }
        format.xml  { render :xml => @user,
          :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @cart=current_cart
    @user = User.find(params[:id])

    if (!params[:user])
     params[:user] = {:address=>params[:address]}     
    end
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_url,
          :notice => "User #{@user.name} was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = "User #{@user.name} deleted"
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

end
