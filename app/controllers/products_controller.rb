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
    # when creating a new product, assigns the new product to @product with it's attributes in  params that will
    # be passed in the form at the view to create this instance.
    respond_to do |format|
      if @product.save
        #if the process of creating the object is sucessful '@product.save', we have different
        #responses to the browser depending on the format requested
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
                      #we get redirected to @product at the view show with the instance that @product carries
                      #and we have the message 'Product was .....'
        format.json { render :show, status: :created, location: @product }
                      # in case of json we have the view show rendered.
                      # searching the difference between render and redirect_to I found this
                      #redirect_to()

                      # Does a full page redirect sending a 302 html code
                      #All variables will be lost
                      #Sends a new request to the system

                      #render()

                      #Sends a 200 html code response
                      #Holds the state of variables
                      #The action is not executed, only the view is rendered
      else
        format.html { render :new }
                       # if it was not saved we can render the form again and the data in the form is not lost?
                      #according to the explanation above?
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product

      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to products_path
      #here is a bit of playing around that I did just putting in practice
      #some knowledge adquired. In case the user types a product_path that
      #does not exist instead a nasty error page they will be redirected to
      # products list
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price)
    #using the symbol :product as a parameter of require this method knows what to look for.
      #the symbol refers to the object in the inst.var @product that had it' attributes
      # defined at new.html.erb.
      #
    end
end
