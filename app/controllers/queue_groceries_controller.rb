class QueueGroceriesController < ApplicationController

  include CurrentBasket

  before_action :set_basket, only: [:create, :decrement]
  # When using the js the decrement action wasn't being able to render the @basket
  #I found out it was not even loading @basket when the PUT request was being processed by looking at the logs
  #turns out I had to set_basket before using this action otherwise it would not load the @basket partial being not able
  #to render it as the request was completed
  before_action :set_queue_grocery, only: [:show, :edit, :update, :destroy, :decrement ]
  #had a hard time to set the decrement action. Only worked it out once I defined that before the decrement
  #method the set_queue_grocery  private action should be triggered.

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
        format.html { redirect_to store_url }
        format.js { @current_item = @queue_grocery }
        # by assigning the @queue_grocery we intend to identify the latest update of the basket
        #to then be able to use the effect blind in that one specifically . since @queue_grocery
        # will be the what is happening when we are calling the create action we have the reference
        # for the use of the effect in @current_item. in this case it will happen when the js is used to add
         # queue_grocery. So it takes us for a change in _queue_grocery.html.erb

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

  #PUT/queue_groceries/1
  #PUT/queue_groceries/1.json

  def decrement
    #this method works in conjunction with the decrement_one method, which is defined in the queue_grocery model
    # def decrement_one
    #  if self.quantity > 1  // this quantity is actually the quantity Queue_grocery'  attribute defined in the schema_migration
    #    self.quantity -= 1  // by calling self we are calling the current content of the object we are calling this method
    #  else                  // upon. so if the @queue_grocery object has in it' quantity attribute the value 5 then the -= 1 magic will happen there.
    #    self.destroy
    #  end
    #  self
    #end
    @queue_grocery.decrement_one
      respond_to do |format|
        if @queue_grocery.save
          format.js {  }
          format.html { redirect_to store_url }

        end
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
