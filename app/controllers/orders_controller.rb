class OrdersController < ApplicationController
include CurrentBasket

  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_basket, only: [:new, :create, :show ]
 #due to be missing this before_action method  and include CurrentCart we were getting an error in application.html.erb
# that happened because for every time we are rendering a partial, we have to make sure that   a value has been set for
# that. Once the value of @basket is set in the method set_basket we have to make sure it is called for every view,
# That is because the partial _basket.html.erb is rendered in when application.html is loaded.


  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    if @basket.queue_groceries.empty?
      redirect_to store_url, notice: "Your basket is empty"
      return

    end
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_queue_groceries_from_basket(@basket)
    #when we call this method on @order we are grabing all line items that
    #were in the basket, setting them free from the basket id (since the
    # basket will be destroyed ahead)
    respond_to do |format|
      if @order.save
        Basket.destroy(session[:basket_id])
        session[:basket_id] = nil
        OrderNotifier.received(@order).deliver_now
        format.html { redirect_to store_url, notice: 'Thank you for your order' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
