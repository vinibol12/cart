class QueueGroceriesController < ApplicationController

  skip_before_action :authorize, only: [:create, :decrement]
  include CurrentBasket

  before_action :set_basket, only: [:create, :decrement]
  before_action :set_queue_grocery, only: [:show, :edit, :update, :destroy, :decrement ]


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

    @queue_grocery = @basket.add_product(product.id)

    respond_to do |format|
      if @queue_grocery.save
        format.html { redirect_to store_url }
        format.js { @current_item = @queue_grocery }
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
