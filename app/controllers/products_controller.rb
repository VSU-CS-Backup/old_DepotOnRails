class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
    @cart = current_cart
    
    if (session[:user_id]!=nil)
      user = User.find(session[:user_id])
      if (user.name == 'admin')
         @products = Product.all
      else
        @products = user.products.all
      end
    else
      @products = Product.all
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @cart = current_cart
    
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @cart = current_cart
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @cart = current_cart
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @cart = current_cart
    # @product = Product.new(params[:product])
    # @product.user_id = session[:user_id]
    
     if (params[:product])
        @product = Product.new(params[:product])
        @product.user_id = session[:user_id]
     else
        params[:product] = {:title=>params[:title], 
                            :description=>params[:description],   
                            :image_url=>params[:image_url], 
                            :price=>params[:price]
                            }
        @product = Product.new(params[:product])
        @product.user_id = session[:user_id]
    end
  
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @cart = current_cart
    @product = Product.find(params[:id])
    
    if (!params[:product])
     params[:product] = {:title=>params[:title], 
                            :description=>params[:description],   
                            :image_url=>params[:image_url], 
                            :price=>params[:price]
                        }     
    end


    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @cart = current_cart
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
end
