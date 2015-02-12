class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
#here we have the Products controller generated with the scaffold. All following
  # is from the scaffold. Above we have the method before_action that is used
  # to call a method before other(s) as set in the parameters.
   # the sintax above means that before the actions, show, edit, update and destroy
  # the private method set_product is  called
  #
  #
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    #the action index set to the inst.var. @products all the instances of the
    #class Product
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
    # use to create a new inst. of Product as new is called on the class and
    #that object is assigned to @product
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save

        format.html { redirect_to @product, notice: 'Product was successfully created.' }

        format.json { render :show, status: :created, location: @product }

      else
        format.html { render :new }

        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product

      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to products_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price)
    end
end
