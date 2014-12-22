class QueueGroceriesController < ApplicationController

  include CurrentBasket

  before_action :set_basket, only: [:create]
  before_action :set_queue_grocery, only: [:show, :edit, :update, :destroy]

  # GET /queue_groceries
  # GET /queue_groceries.json
  def index
    @queue_groceries = QueueGrocery.all
  end

  # GET /queue_groceries/1
  # GET /queue_groceries/1.json
  def show
  end

  # GET /queue_groceries/new
  def new
    @queue_grocery = QueueGrocery.new
  end

  # GET /queue_groceries/1/edit
  def edit
  end

  # POST /queue_groceries
  # POST /queue_groceries.json
  def create
    product = Product.find(params[:product_id])
# here we are creating a new kind of relationship from what we've seen so far
   #the product that was added to the basket in the store through the button will
    # redirect to this create action. So we have the selected product's id
    # assigned to a local variable product. Which as we know will die as the action
    #ends.

    @queue_grocery = @basket.add_product(product.id)

    #UNDER WE HAVE OLD VERSION BEFORE SMARTER CART CHANGES
    #@queue_grocery = @basket.queue_groceries.build(product: product)
    # this has more stuff going on. we have that product found passed into
    # @basket.queue_groceries.build. According to the book it causes a new
    # queue grocery relationship to be create between that @basket object and
    # the product. I understand that  queue.groceries is a method in the way
    #rails uses its conventions through the names of entities.

    respond_to do |format|
      if @queue_grocery.save
        format.html { redirect_to @queue_grocery.basket }
        format.json { render :show, status: :created, location: @queue_grocery }
      else
        format.html { render :new }
        format.json { render json: @queue_grocery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /queue_groceries/1
  # PATCH/PUT /queue_groceries/1.json
  def update
    respond_to do |format|
      if @queue_grocery.update(queue_grocery_params)
        format.html { redirect_to @queue_grocery, notice: 'Queue grocery was successfully updated.' }
        format.json { render :show, status: :ok, location: @queue_grocery }
      else
        format.html { render :edit }
        format.json { render json: @queue_grocery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /queue_groceries/1
  # DELETE /queue_groceries/1.json
  def destroy
    @queue_grocery.destroy
    respond_to do |format|
      format.html { redirect_to queue_groceries_url, notice: 'Queue grocery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_queue_grocery
      @queue_grocery = QueueGrocery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def queue_grocery_params
      params.require(:queue_grocery).permit(:product_id)
    end
end
