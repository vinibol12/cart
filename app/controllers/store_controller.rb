class StoreController < ApplicationController

  skip_before_action :authorize
  include CurrentBasket
  before_action :set_basket

  def index

    @products = Product.order(:title)
    @count = increment_counter
    @date = Date.today
    @time = Time.now

  end


end

private

def increment_counter
  if session[:counter].nil?
    session[:counter]= 0
  else
    session[:counter]+= 1
  end
end