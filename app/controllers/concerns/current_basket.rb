module CurrentBasket
 #according to the book Rails makes the current session
  #look like a hash to the controller (need clarification on what that means)
  # we'll store the id of the Basket in the session by indexinf it with the symbol
  #:basket_id

  extend ActiveSupport::Concern

  private

  def set_basket
    @basket = Basket.find(session[:basket_id])
      #this method makes the value of @basket be set to the value of
      #Current cart
     #here we are assigning the id of the basket
      #to the inst.var @basket

  rescue ActiveRecord::RecordNotFound
    #in case Active Record does not find that basket id
    #the request will be rescued  and rails
    #will create a new object Basket
    @basket = Basket.create
    session[:basket_id] = @basket.id
    #we have the object of Basket stored in @basket. By calling
    # .id we set that as the value of the key :basket_id

  end
end