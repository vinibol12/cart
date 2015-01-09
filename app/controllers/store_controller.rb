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
#we generated a new controllwe. The store controller. In the routes file we set
# store#index as the root view. now in the store controller we assigned all the
#objects of the class Product, ordered by title, to the inst.var. @products

private

def increment_counter
  if session[:counter].nil?
    session[:counter]= 0
  else
    session[:counter]+= 1
  end
end